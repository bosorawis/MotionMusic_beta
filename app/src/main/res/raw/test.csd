<CsoundSynthesizer>
<CsOptions>
-o dac -d -b512 -B2048
</CsOptions>
<CsInstruments>
nchnls=2
0dbfs=1
ksmps=32
sr = 44100

ga1 init 0

instr 1

itie tival
i_instanceNum = p4

S_freq sprintf "frequency_mod.%d", i_instanceNum
S_vol sprintf "volume_mod.%d", i_instanceNum

kfreq chnget S_freq
kvol chnget S_vol


kenv linsegr 0, .001, 1, .1, 1, .25, 0
kfinalfreq port kfreq, 0.01

;a1 oscil3 .8, 220+kx , 1
a1 vco2 kvol*.5 * kenv, 60 + (log(1 - kfinalfreq) * 3000), 0

ga1 = ga1 + a1

endin

instr 2
i_instanceNum = p4

S_flanger sprintf "flanger_mod.%d", i_instanceNum
S_reverb sprintf "reverb_mod.%d", i_instanceNum



kflanger chnget S_flanger
kreverb chnget S_reverb


kcutoff = 6000
kresonance = .2

;Low pass filter
a1 moogladder ga1, kcutoff, kresonance


;Flanger
kfeedback = p4
adel linseg 0, p3*.7, 0.02 , p3*.7, 0	;max delay time =20ms
aflg flanger ga1, adel, kreverb
aflgout clip aflg, 1,1

;Reverb
aL, aR reverbsc a1, a1, kreverb, 5000



outs aL+aflgout, aR+aflgout
;outs aL, aR
ga1 = 0

endin


</CsInstruments>
<CsScore>
f1 0 16384 10 1

i2 0 360000
 
</CsScore>
</CsoundSynthesizer>

