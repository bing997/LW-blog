import requests
import re
import json

session = requests.Session()
session.headers['User-Agent'] = 'Mozilla/5.0'

# Correct URLs (from category pages)
CORRECT_URLS = [
    ("08", "项目案例：招聘网中的简历模板", "http://localhost:4000/2024/08/20/bootstrap/document/08-%E9%A1%B9%E7%9B%AE%E6%A1%88%E4%BE%8B%EF%BC%9A%E6%8B%9B%E8%81%98%E7%BD%91%E4%B8%AD%E7%9A%84%E7%AE%80%E5%8E%86%E6%A8%A1%E6%9D%BF/"),
    ("09", "项目案例：仿星巴克网站", "http://localhost:4000/2024/08/20/bootstrap/document/09-%E9%A1%B9%E7%9B%AE%E6%A1%88%E4%BE%8B%EF%BC%9A%E4%BB%BF%E6%98%9F%E5%B7%B4%E5%85%8B%E7%BD%91%E7%AB%99/"),
    ("10", "项目案例：相册类博客项目", "http://localhost:4000/2024/08/20/bootstrap/document/10-%E9%A1%B9%E7%9B%AE%E6%A1%88%E4%BE%8B%EF%BC%9A%E7%9B%B8%E5%86%8C%E7%B1%BB%E5%8D%9A%E5%AE%A2%E9%A1%B9%E7%9B%AE/"),
    ("11", "项目案例：设计流行企业网站", "http://localhost:4000/2024/08/20/bootstrap/document/11-%E9%A1%B9%E7%9B%AE%E6%A1%88%E4%BE%8B%EF%BC%9A%E8%AE%BE%E8%AE%A1%E6%B5%81%E8%A1%8C%E4%BC%81%E4%B8%9A%E7%BD%91%E7%AB%99/"),
    ("12", "项目案例：Web设计与定制网站", "http://localhost:4000/2024/08/20/bootstrap/document/12-%E9%A1%B9%E7%9B%AE%E6%A1%88%E4%BE%8B%EF%BC%9AWeb%E8%AE%BE%E8%AE%A1%E4%B8%8E%E5%AE%9A%E5%88%B6%E7%BD%91%E7%AB%99/"),
    ("13", "项目案例：开发神影视频网站", "http://localhost:4000/2024/08/20/bootstrap/document/13-%E9%A1%B9%E7%9B%AE%E6%A1%88%E4%BE%8B%EF%BC%9A%E5%BC%80%E5%8F%91%E7%A5%9E%E5%BD%B1%E8%A7%86%E9%A2%91%E7%BD%91%E7%AB%99/"),
]

# User-expected sections
USER_SECTIONS = ["案例概述", "涉及知识点", "实现步骤", "完整代码", "关键技术解析"]
# Actual top-level (h2) section signatures in the case files
ACTUAL_SECTIONS = ["案例概述", "实现步骤", "关键技术解析", "小结"]

results = []

for case_num, title_part, url in CORRECT_URLS:
    rec = {
        "case_num": case_num,
        "title_part": title_part,
        "url": url,
        "status": None,
        "title": None,
        "h1": None,
        "user_sections_found": {},
        "actual_h2_sections": [],
        "actual_h3_subsections": [],
        "notes": []
    }
    try:
        r = session.get(url, timeout=15)
        rec["status"] = r.status_code
        if r.apparent_encoding:
            r.encoding = r.apparent_encoding
        html = r.text
        # Title
        tmatch = re.search(r'<title>(.*?)</title>', html, re.S)
        if tmatch:
            rec["title"] = tmatch.group(1).strip()
        # H1
        h1s = re.findall(r'<h1[^>]*>(.*?)</h1>', html, re.S)
        if h1s:
            rec["h1"] = re.sub(r'<[^>]+>', '', h1s[0]).strip()
        # Look for user expected sections in raw HTML (these are part of body text)
        for sec in USER_SECTIONS:
            rec["user_sections_found"][sec] = sec in html
        # h2
        h2s = re.findall(r'<h2[^>]*>(.*?)</h2>', html, re.S)
        rec["actual_h2_sections"] = [re.sub(r'<[^>]+>', '', h).strip() for h in h2s]
        # h3
        h3s = re.findall(r'<h3[^>]*>(.*?)</h3>', html, re.S)
        rec["actual_h3_subsections"] = [re.sub(r'<[^>]+>', '', h).strip() for h in h3s]
    except Exception as e:
        rec["error"] = str(e)
    results.append(rec)

print("\n========= HEXO BLOG CASE STUDY VERIFICATION =========\n")
for r in results:
    print(f"--- Case {r['case_num']}: {r['title_part']} ---")
    print(f"  URL: {r['url']}")
    print(f"  HTTP Status: {r['status']}")
    print(f"  <title>: {r['title']}")
    print(f"  H1: {r['h1']}")
    print(f"  User-expected sections found in HTML:")
    for sec, found in r['user_sections_found'].items():
        print(f"    [{('YES' if found else 'NO ')}] {sec}")
    print(f"  Actual H2 chapter sections:")
    for s in r['actual_h2_sections']:
        print(f"    - {s}")
    print(f"  Actual H3 subsections (first 5):")
    for s in r['actual_h3_subsections'][:5]:
        print(f"    - {s}")
    print()

# Save full results
with open('e:/softeem/LW/blog/case_results.json', 'w', encoding='utf-8') as f:
    json.dump(results, f, ensure_ascii=False, indent=2)
