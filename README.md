📅 Moodle Calendar Notifier
============================
Get notified of your moodle upcomming deadlines

# ✅ Prerequisites
Make sure you have Python 3 installed. Then install the necessary dependencies with:
```bash
pip install -r requirements.txt
```

# ⚙️ Configuration
Modify in ***.env*** the value of the variable ***CALENDAR_URL*** with your moodle calendar URL.
You can get this URL here: https://moodle.epita.fr/calendar/export.php

# 🚀 Run at startup
To add your script to the boot programs, simply go to the folder corresponding to your operating system.
Then, modify the indicated field in ***add_to_boot_programs*** file with your moodle-calendar-notifier repository path.
Finally, execute the program.

# 🎉 Et voilà
Your program is now ready to be used, just restart your computer to make it works !

_Note: This program downloads your calendar every time it has internet access when running, thus even works offline._