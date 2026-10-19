# 章节背景图挑选（index 与 story 共用）
import os, sys
sys.path.insert(0, r'G:\project\其他\game\tools')
from site_lib import ASSETS, CHAP_BG, find_image

KEYWORD_BG = {
    '序章·系统与引导':              ['BG_Ark_base', 'BG_Base_Control_Room', 'BG_BSpeak'],
    '第一章·人生的终结、命运的开始':  ['BG_City_street', 'BG_Base_Corridor', 'BG_Ark_base'],
    '第二章·想守护的她、被守护的你':  ['BG_APT_livingRoom', 'BG_City_coffeeShop', 'BG_Base_Laboratory'],
    '第三章·神魂的治愈、身体的诅咒':  ['BG_Fabiola_Church', 'BG_Base_Laboratory', 'BG_Ark_base_corridor'],
    '活动剧情':                     ['Activity_Story_001', 'BG_City_street1', 'BG_Ark_base'],
    '支线剧情':                     ['BG_City_street2', 'BG_APT_bedRoom', 'BG_Depot1'],
    '测试与其它':                   ['BG_BSpeak', 'BG_ECT', 'BG_Ark_elevator'],
}

_cache = {}

def pick_bg(chap):
    """给章节挑一张背景图（带缓存）"""
    name = chap['name'] if isinstance(chap, dict) else str(chap)
    if name in _cache:
        return _cache[name]
    out = None
    nm = CHAP_BG.get(name)
    if nm:
        out = find_image(nm)
    if not out:
        for kw in KEYWORD_BG.get(name, []):
            out = find_image(kw)
            if out:
                break
    if not out:
        for a in ASSETS:
            if a['k'] == 'image' and a['p'].startswith('06_美术素材/07_背景场景/'):
                out = a['p']
                break
    _cache[name] = out
    return out
