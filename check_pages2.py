import requests
import re

session = requests.Session()
session.headers['User-Agent'] = 'Mozilla/5.0'

# Get all category pages and dump all links from page 2
for pg in [1, 2]:
    cat_url = f"http://localhost:4000/categories/bootstrap/page/{pg}/" if pg > 1 else "http://localhost:4000/categories/bootstrap/"
    r = session.get(cat_url, timeout=15)
    print(f"\n========= Category page {pg}: {r.status_code} =========")
    # Check encoding
    print(f"Apparent encoding: {r.apparent_encoding}")
    print(f"Content-Encoding: {r.headers.get('Content-Encoding', 'none')}")
    # Re-decode if needed
    if r.apparent_encoding and r.apparent_encoding.lower() != 'utf-8':
        try:
            r.encoding = r.apparent_encoding
        except:
            pass
    html = r.text
    all_links = re.findall(r'<a[^>]+href="([^"]+)"[^>]*>(.*?)</a>', html, re.S)
    print(f"All href on page: {len(all_links)}")
    for h, t in all_links:
        t_clean = re.sub(r'<[^>]+>', '', t).strip()
        if h.startswith('/') and 'bootstrap' in h:
            decoded = requests.utils.unquote(h)
            print(f"  HREF: {h}")
            print(f"    TEXT: {t_clean[:80]}")
            print(f"    DECODED: {decoded}")
