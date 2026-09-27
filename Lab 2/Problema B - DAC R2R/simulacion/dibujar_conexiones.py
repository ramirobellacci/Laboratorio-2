from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

BASE = Path(__file__).resolve().parent
im = Image.new('RGB', (1480, 1160), '#ffffff')
d = ImageDraw.Draw(im)
FONT = Path('C:/Windows/Fonts')
def font(size, bold=False):
    return ImageFont.truetype(str(FONT / ('arialbd.ttf' if bold else 'arial.ttf')), size)
def text(x, y, s, size=23, fill='#20252b', anchor='la', bold=False):
    d.text((x,y), s, font=font(size,bold), fill=fill, anchor=anchor)
def wire(points, color='#26714a', width=4):
    d.line(points, fill=color, width=width)
def resistor_h(x1,x2,y,label):
    wire([(x1,y),(x1+14,y)])
    d.rectangle((x1+14,y-10,x2-14,y+10),fill='white',outline='#20252b',width=3)
    wire([(x2-14,y),(x2,y)])
    text((x1+x2)//2,y-40,label,22,anchor='ma')
def resistor_v(x,y1,y2,label):
    wire([(x,y1),(x,y1+12)])
    d.rectangle((x-10,y1+12,x+10,y2-12),fill='white',outline='#20252b',width=3)
    wire([(x,y2-12),(x,y2)])
    text(x+22,(y1+y2)//2,label,22,anchor='lm')
def ground(x,y):
    wire([(x,y),(x,y+12)])
    for delta,half in [(12,20),(20,13),(28,6)]:
        wire([(x-half,y+delta),(x+half,y+delta)])
    text(x,y+36,'GND',20,anchor='ma')

text(45,22,'PROTEUS  |  ATmega328P de tu captura (32 pines)',32,bold=True)
text(45,66,'DAC R-2R de 8 bits  /  Los puntos negros indican uniones de cables',23,fill='#505860')

# The MCU symbol groups pins by function; printed numbers match the supplied screenshot.
d.rectangle((380,245,700,955),fill='#eef3f0',outline='#20252b',width=3)
text(540,904,'ATMEGA328P',26,anchor='ma',bold=True)
text(540,938,'U1',19,anchor='mm')

wire([(440,245),(440,136)],'#b53b39')
text(440,105,'+5 V',24,anchor='ma',bold=True)
text(440,265,'18  AVCC',22,anchor='ma')
wire([(600,245),(600,213)])
resistor_v(600,146,213,'10 kΩ')
wire([(600,146),(600,136)],'#b53b39')
text(600,105,'+5 V',24,anchor='ma',bold=True)
text(600,265,'29  RESET',22,anchor='ma')

d.rectangle((35,465,225,665),fill='#fff8ed',outline='#20252b',width=3)
text(130,481,'VIRTUAL',22,anchor='ma',bold=True)
text(130,508,'TERMINAL',22,anchor='ma',bold=True)
for y, external, internal in [(560,'TXD','30  PD0 / RXD'),(625,'RXD','31  PD1 / TXD')]:
    text(210,y-25,external,22,anchor='ra')
    wire([(225,y),(380,y)],'#ae6926')
    text(394,y-25,internal,22)
text(130,686,'9600  |  8N1',22,anchor='ma')

nodes=[(13,'PB1',7),(12,'PB0',6),(11,'PD7',5),(10,'PD6',4),
       (9,'PD5',3),(2,'PD4',2),(1,'PD3',1),(32,'PD2',0)]
for i,(pin,port,bit) in enumerate(nodes):
    y=320+i*80
    text(683,y-27,f'{pin}  {port}',24,anchor='ra',bold=True)
    wire([(700,y),(855,y)])
    resistor_h(855,995,y,'2 kΩ')
    wire([(995,y),(1160,y)])
    d.ellipse((1154,y-6,1166,y+6),fill='#20252b')
    text(1085,y-30,f'N{bit}',22,bold=True)
    if i<7:
        resistor_v(1160,y+7,y+73,'1 kΩ')

wire([(1160,320),(1360,320)])
text(1360,338,'VOUT',25,anchor='ma',bold=True)
d.rectangle((1245,135,1450,250),fill='#eef4fa',outline='#20252b',width=3)
text(1347,154,'OSCILOSCOPIO',21,anchor='ma',bold=True)
text(1360,213,'A',26,anchor='ma',bold=True)
wire([(1360,250),(1360,320)])
resistor_v(1160,891,963,'2 kΩ')
wire([(1160,880),(1160,891)])
ground(1160,963)
text(1280,925,'Terminación',21)

text(805,123,'Alimentación oculta:',22,bold=True)
wire([(820,173),(820,204)],'#b53b39')
d.polygon([(810,178),(820,162),(830,178)],outline='#b53b39',width=3)
text(842,165,'VCC = +5 V',22)
ground(1075,163)

text(45,1006,'7 resistencias de 1 kΩ + 9 resistencias de 2 kΩ en la escalera.',25,bold=True)
text(45,1050,'Clock Frequency: 16MHz     |     Program File: dac_r2r_uart.hex',24)
text(45,1092,'Los otros pines visibles quedan libres. El osciloscopio virtual usa GND como referencia.',22)
im.save(BASE / 'conexiones_proteus_atmega32.png')
