---
title: {{ replace .Name "-" " " | title }}
date: {{ .Date }}
draft: false
#if this can be bought as both physical and digital
digital_price: 10
physical_price: 15
#for digital only
display_price: 3
digital: false
sample_img_1: /shop/{{ .Name }}/sample.jpg
sample_audio_1: /shop/{{ .Name }}/sample.m4a

---

## Subheading goes here...

Short description of the piece goes here.
