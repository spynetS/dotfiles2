#!/usr/bin/env python3
import json
import subprocess

def stream_niri_events():
    proc = subprocess.Popen(
        ["niri", "msg", "--json", "event-stream"],
        stdout=subprocess.PIPE,
        text=True,
        bufsize=1,
    )

    windows = {}

    for line in proc.stdout:
        try:
            data = json.loads(line)
            # Handle initial state or window change events
            if "WindowCreated" in data or "WindowChanged" in data or "InitialState" in data:
                window_list = extract_windows(data)
                update_eww(window_list)
            elif "WindowRemoved" in data:
                removed_id = data["WindowRemoved"]
                windows.pop(str(removed_id), None)
                update_eww(list(windows.values()))
        except Exception as e:
            print(f"[ERROR] {e}")

def extract_windows(data):
    windows = []

    # Initial state
    if "InitialState" in data:
        for w in data["InitialState"]["windows"]:
            windows.append({
                "id": w["id"],
                "title": w["title"] or w["app_id"]
            })
    elif "WindowCreated" in data:
        w = data["WindowCreated"]
        windows.append({
            "id": w["id"],
            "title": w["title"] or w["app_id"]
        })
    elif "WindowChanged" in data:
        w = data["WindowChanged"]
        windows.append({
            "id": w["id"],
            "title": w["title"] or w["app_id"]
        })

    return windows

def update_eww(windows):
    json_data = json.dumps(windows)
    subprocess.run(["eww", "update", f"open_windows={json_data}"])

if __name__ == "__main__":
    stream_niri_events()
