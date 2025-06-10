import requests
import pytz
import os
from dotenv import load_dotenv
from ics import Calendar
from datetime import datetime, timedelta
import asyncio
from desktop_notifier import DesktopNotifier, Urgency, Button
import webbrowser
from pathlib import Path

notifier = DesktopNotifier()

async def pushNotif(title, msg, link = True):
    if link:
        await notifier.send(
                        title = title,
                        message = msg,
                        urgency=Urgency.Normal,
                        icon=Path(os.path.abspath(os.getenv("ICON"))),
                        buttons=[
                            Button(
                                title="View on moodle",
                                on_pressed=lambda: webbrowser.open(os.getenv("CALENDAR_LINK")),
                            )
                        ],
                    )
    else:
        await notifier.send(title = title,
                      message = msg,
                      urgency=Urgency.Normal,
                      icon=os.path.abspath(os.getenv("ICON"))
                    )

def getCalendar():
    try:
        response = requests.get(os.getenv("CALENDAR_URL"), timeout=5)
        if response.status_code != 200:
            print("Erreur lors du téléchargement du calendrier :", response.status_code)
            pushNotif("Erreur", "Erreur lors du téléchargement du calendrier", False)
            return None
        calendar = Calendar(response.text)
        with open("moodle-calendar.ics", "w") as f:
            f.write(calendar.serialize())
    
    except requests.ConnectionError:
        print("Cannot fetch the calendar")
    
    with open('moodle-calendar.ics', 'r') as f:
        res = Calendar(f.read())
    return res

async def main():
    load_dotenv()
    calendar = getCalendar()
    now = datetime.now()
    limit = now + timedelta(int(os.getenv("PERIOD")))
    timezone = pytz.timezone("Europe/Paris")
    notified = False
    nextEvents = []

    if calendar is None:
        await pushNotif("Error", "Cannot access calendar", False)
        return
    
    for event in calendar.events:
        if len(nextEvents) == 0:
            nextEvents.append(event)

        elif nextEvents[0].end.date() >= event.end.date():
            if nextEvents[0].end.date() > event.end.date():
                nextEvents.clear()
            nextEvents.append(event)
            
        if event.end.datetime <= timezone.localize(limit) and event.end.datetime >= timezone.localize(now):
            notified = True
            endDate = event.end.astimezone(timezone).strftime('%d/%m/%Y')
            endTime = event.end.astimezone(timezone).strftime('%H:%M')
            message = "Ends " + endDate + " at " + endTime
            if event.end.date() == now.date():
                message = "Ends today at " + endTime
            await pushNotif(event.name, message)

    if not notified:
        for event in nextEvents:
            endDay = event.end.astimezone(timezone).strftime('%d/%m/%Y %H:%M')
            message = "Due date: " + endDay
            await pushNotif(event.name, message)

asyncio.run(main())