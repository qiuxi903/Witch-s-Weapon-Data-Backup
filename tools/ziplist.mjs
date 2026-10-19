// Read ZIP central directory over HTTP range requests to list entries without downloading the whole file.
const url = process.argv[2];

async function head() {
  const r = await fetch(url, { headers: { Range: 'bytes=0-0' } });
  const cr = r.headers.get('content-range');
  const total = cr ? parseInt(cr.split('/')[1], 10) : parseInt(r.headers.get('content-length'), 10);
  return total;
}

async function getRange(a, b) {
  const r = await fetch(url, { headers: { Range: `bytes=${a}-${b}` } });
  if (!r.ok && r.status !== 206) throw new Error('HTTP ' + r.status);
  return Buffer.from(await r.arrayBuffer());
}

const total = await head();
console.error('[size]', total);

// EOCD: scan last 64KB for signature 0x06054b50
const tailLen = Math.min(65536, total);
const tail = await getRange(total - tailLen, total - 1);
let eocd = -1;
for (let i = tail.length - 22; i >= 0; i--) {
  if (tail.readUInt32LE(i) === 0x06054b50) { eocd = i; break; }
}
if (eocd < 0) { console.log('NO EOCD FOUND'); process.exit(1); }

const cdSize = tail.readUInt32LE(eocd + 12);
const cdOffset = tail.readUInt32LE(eocd + 16);
console.error('[cd] offset=', cdOffset, 'size=', cdSize);

// Fetch central directory
const cd = await getRange(cdOffset, cdOffset + cdSize - 1);

const entries = [];
let p = 0;
while (p < cd.length - 4) {
  if (cd.readUInt32LE(p) !== 0x02014b50) break;
  const compSize = cd.readUInt32LE(p + 20);
  const uncompSize = cd.readUInt32LE(p + 24);
  const nameLen = cd.readUInt16LE(p + 28);
  const extraLen = cd.readUInt16LE(p + 30);
  const commentLen = cd.readUInt16LE(p + 32);
  const name = cd.slice(p + 46, p + 46 + nameLen).toString('utf8');
  entries.push({ name, compSize, uncompSize });
  p += 46 + nameLen + extraLen + commentLen;
}

console.log('TOTAL ENTRIES:', entries.length);
console.log('--- OBB / large entries ---');
for (const e of entries) {
  if (/\.obb$/i.test(e.name) || e.uncompSize > 5 * 1024 * 1024) {
    console.log(`  ${e.name}  uncompressed=${e.uncompSize} (${(e.uncompSize / 1048576).toFixed(1)} MB)`);
  }
}
console.log('--- all entries ---');
for (const e of entries) console.log(`  ${e.name}  ${e.uncompSize}`);
