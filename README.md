

<p align="center">
  <h1 align="center">Telegram Auto Sender</h1>
  <p align="center">
    A simple script that automatically sends your message<br>
    to any public or private Telegram chat
  </p>
</p>

## ✨ Features

- Sends messages to private chats, groups or channels  
- Works using a regular user account (not a bot)  
- Supports scheduled / periodic sending  
- Built-in send counter  

## Important Warning

**Do NOT use this script for spamming!**  
Telegram permanently bans accounts (even regular user accounts) for flooding, unwanted messages, bulk messaging and automation.

## Setup (one-time)

1. Go to:  
   https://my.telegram.org/auth  
   Enter the phone number linked to your Telegram account.

2. After login go to **API development tools** → create new application.  
   Save these two values:  
   - `api_id` (number)  
   - `api_hash` (long string)

3. Get the **chat ID** where you want to send messages:  
   - Open Telegram Desktop  
   - Find any message in the target chat  
   - Right-click → **Copy Message Link**  
   - You’ll get something like: `https://t.me/c/1234567890/123`  
   - Take the number after `/c/` and add `-100` in front  
     Example: `-1001234567890` ← this is your chat_id

4. Open the script file (usually `main.py` or similar) and fill in:

```python
API_ID    = 1234567
API_HASH  = "your_api_hash_here"
PHONE     = "+79123456789"        # your phone number
CHAT_ID   = -1001234567890        # the one you just got
MESSAGE   = "Your message goes here ✈️"
```
### Running automatically on Windows

Recommended way — Windows Task Scheduler:

- Create a new task (not basic task)
- Check: **Run only when user is logged on**
- Triggers:
  - At log on
  - On workstation unlock
- Action → Start a program:
  - Program: `wscript.exe`
  - Arguments: `"C:\Scripts\run-hidden.vbs"`  
    (replace with the actual path to your vbs file that runs python hidden)
- Conditions → uncheck **Start the task only if the computer is on AC power**

**Important:**  
Stable internet + working VPN (if Telegram requires VPN in your region) must be active. Otherwise authorization will fail and the script won’t run.
