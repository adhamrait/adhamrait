#!/bin/sh
# Usage: ./new_report.sh <slug> "<Peak name as in _data/mountains.yml>" [YYYY-MM-DD]
# Example: ./new_report.sh whitney "Whitney" 2023-10-14
set -e
[ $# -ge 2 ] || { sed -n 2,3p "$0"; exit 1; }
slug=$1; peak=$2; date=${3:-$(date +%F)}
file="_reports/$slug.md"
[ -e "$file" ] && { echo "$file already exists"; exit 1; }
grep -q "name: \"\{0,1\}$peak\"\{0,1\}," _data/mountains.yml || echo "warning: \"$peak\" not found in _data/mountains.yml; the table won't link to it"
mkdir -p "assets/climbing/$slug"
cat > "$file" <<EOT
---
layout: report
peak: $peak
title: $peak
date: $date
route:
partners: []
distance:
gain:
time:
---

Write the report here.

{% include photo.html src="$slug/photo.jpg" caption="" %}
EOT
echo "Created $file (put photos in assets/climbing/$slug/)"
