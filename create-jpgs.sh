#captures
sips -Z 1500 --setProperty format jpeg --setProperty formatOptions 90  /mnt/c/Users/Yo/OneDrive/Desarrollo/Emprendimiento/Seb/captures-original/*.png -o public/captures

#thumbs
sips -Z 300 --setProperty format jpeg --setProperty formatOptions 50  /mnt/c/Users/Yo/OneDrive/Desarrollo/Emprendimiento/Seb/captures-original/*.png -o public/thumbs
