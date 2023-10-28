night = playlist("Lunar_Waves.xspf")
day = playlist("Waves_and_Sun.xspf")
eternal = random(weights=[1,1], [day,night]);
emergency = single("bgm.mp3")
s = fallback(track_sensitive=false, [eternal, emergency])

# server name goes here
def send_metadata_to_webpage(title, artist)
    system("curl -X POST -d 'title=#{title}' -d 'artist=#{artist}' file:///C:/Users/Aidan/Music/liquidsoap-2.2.1-win64/main.html")
end

def log_song(m)
	file.write(append=true, data="#{metadata.json.stringify(m)}\n","songs.xml")
 	title = m["title"]
	artist = m["artist"]
	send_metadata_to_webpage(title, artist)
end

s.on_track(log_song)
output.icecast(%ffmpeg(format="mp3",%audio(codec="libmp3lame")), host="localhost", port=8443, password="hackme", mount="my-radio.mp3", s)