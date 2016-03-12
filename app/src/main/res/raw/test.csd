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
ga2 init 0
instr 1

itie tival
i_instanceNum = p4

S_freq sprintf "frequency_mod.%d", i_instanceNum
S_vol sprintf "volume_mod.%d", i_instanceNum
S_vibrato sprintf "vibrato_mod.%d", i_instanceNum

kfreq chnget S_freq
kvol chnget S_vol
kvib chnget S_vibrato

kenv linsegr 0, .001, 1, .1, 1, .25, 0
kportfreq port kfreq, 0.01
kportvol port kvol, 0.01

kvibrato vibr 500, kvib*10, 1

ainst vco2 kportvol*.1 * kenv, 60 + (log(1-kportfreq) * 3000)+ kvibrato, 0
;a1 vco2 kvol*.5 * kenv, 10000 , 0

;gifn	ftgen	0,0, 257, 9, .5,1,270

;adist distort ainst, 1, gifn


ga1 = ga1 + ainst

endin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;=======================================================
;*****************Instrument 2**************************
;=======================================================
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


;=============Flanger========================================
kfeedback = p4
adel linseg 0, p3*.7, 0.02 , p3*.7, 0	;max delay time =20ms
aflg flanger ga1, adel, kreverb
aflgout clip aflg, 1,1
;=============================================================

;=============Reverb==========================================
aL, aR reverbsc a1, a1, kreverb, 5000

;=============================================================

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

