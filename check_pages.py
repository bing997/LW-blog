import requests
import re
import json

session = requests.Session()
session.headers['User-Agent'] = 'Mozilla/5.0'

# Get all category pages
for pg in [1, 2, 3]:
    cat_url = f"http://localhost:4000/categories/bootstrap/page/{pg}/" if pg > 1 else "http://localhost:4000/categories/bootstrap/"
    try:
        r = session.get(cat_url, timeout=15)
        print(f"=== Category page {pg}: {r.status_code}, len={len(r.text)} ===")
        all_links = re.findall(r'<a[^>]+href="([^"]+)"[^>]*>(.*?)</a>', r.text, re.S)
        for h, t in all_links:
            t_clean = re.sub(r'<[^>]+>', '', t).strip()
            if '/bootstrap/' in h and '/page/' not in h and h not in ['/categories/bootstrap/', '/tags/bootstrap/'] and t_clean:
                # Decode URL parts to look for 0X
                decoded = requests.utils.unquote(h)
                m = re.search(r'/0(\d+)-', decoded)
                if m:
                    print(f"  [{h}] | {t_clean}")
    except Exception as e:
        print(f"Error on page {pg}: {e}")
