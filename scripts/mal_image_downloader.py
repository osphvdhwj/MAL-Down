#!/usr/bin/env python3
"""
MyAnimeList XML Image Downloader
Downloads images from MAL anime/manga XML exports with metadata embedding
"""

import os
import sys
import xml.etree.ElementTree as ET
import requests
from pathlib import Path
import time

class MALImageDownloader:
    def __init__(self, xml_file, output_dir="MAL_Images"):
        self.xml_file = xml_file
        self.output_dir = output_dir
        self.max_retries = 5
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
        })
        
    def parse_xml(self):
        """Parse MAL XML file and extract entries"""
        tree = ET.parse(self.xml_file)
        root = tree.getroot()
        
        content_type = "anime" if "anime" in self.xml_file.lower() else "manga"
        
        entries = []
        for item in root.findall('.//anime') if content_type == "anime" else root.findall('.//manga'):
            entry = self.extract_entry_data(item, content_type)
            entries.append(entry)
        
        return entries, content_type
    
    def extract_entry_data(self, item, content_type):
        """Extract all relevant data from XML entry"""
        entry = {
            'id': self.get_text(item, 'series_animedb_id' if content_type == 'anime' else 'manga_mangadb_id'),
            'title': self.get_text(item, 'series_title'),
            'image_url': self.get_text(item, 'series_image'),
            'type': self.get_text(item, 'series_type'),
            'tags': self.get_text(item, 'my_tags'),
            'content_type': content_type
        }
        return entry
    
    def get_text(self, element, tag):
        """Safely extract text from XML element"""
        child = element.find(tag)
        return child.text if child is not None and child.text else ""
    
    def download_image(self, url, filename, max_retries=5):
        """Download image with retry mechanism"""
        for attempt in range(max_retries):
            try:
                response = self.session.get(url, timeout=30)
                response.raise_for_status()
                
                with open(filename, 'wb') as f:
                    f.write(response.content)
                
                return True, None
            
            except Exception as e:
                if attempt < max_retries - 1:
                    time.sleep(2 ** attempt)
                    continue
                return False, str(e)
        
        return False, "Max retries exceeded"
    
    def run(self):
        """Main execution method"""
        print("="*60)
        print("MyAnimeList XML Image Downloader")
        print("="*60)
        
        entries, content_type = self.parse_xml()
        print(f"\nFound {len(entries)} {content_type} entries")
        
        Path(self.output_dir).mkdir(parents=True, exist_ok=True)
        
        success = 0
        for idx, entry in enumerate(entries, 1):
            print(f"[{idx}/{len(entries)}] {entry['title']}")
            
            if entry['image_url']:
                filename = f"{self.output_dir}/{entry['title'][:50]}_{entry['id']}.jpg"
                downloaded, error = self.download_image(entry['image_url'], filename, self.max_retries)
                
                if downloaded:
                    print(f"  ✓ Downloaded")
                    success += 1
                else:
                    print(f"  ✗ Failed: {error}")
        
        print("\n" + "="*60)
        print(f"Downloaded: {success}/{len(entries)}")
        print("="*60)

def main():
    if len(sys.argv) < 2:
        print("Usage: python mal_image_downloader.py <xml_file>")
        sys.exit(1)
    
    xml_file = sys.argv[1]
    if not os.path.exists(xml_file):
        print(f"Error: {xml_file} not found")
        sys.exit(1)
    
    downloader = MALImageDownloader(xml_file)
    downloader.run()

if __name__ == "__main__":
    main()