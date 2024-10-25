#!/bin/bash

sunrise=$(cut -d'"' -f 6 fichier);
sunset=$(cut -d'"' -f 10 fichier);

echo "Sunrise is expected at $sunrise AM and sunset at $sunset."