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
S_vibrato sprintf "vibrato_mod.%d", i_instanceNum

kfreq chnget S_freq
kvol chnget S_vol
kvib chnget S_vibrato

kportfreq port kfreq, 0.01
kportvol port kvol, 0.01

kfreqmod oscil 400, 4*kvib, 1

kenv linsegr 0, .001, 1, .1, 1, .25, 0

a1 oscil kportvol*kenv, 100+440*kportfreq*2 + kfreqmod, 1
aenv adsr 0.2, 1, 1, 0.2

ga1 = ga1 + (a1*aenv)
outs a1*aenv, a1*aenv

endin

instr 2

itie tival
i_instanceNum = p3


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

ainst vco2 kvol * kenv, 60 + (log(1-kfreq) * 3000)+ kvibrato, 0
ga1 = ga1 + ainst



outs ainst, ainst

endin

instr 3

;kcutoff chnget "cutoff"
;kresonance chnget "resonance"

kcutoff = 6000
kresonance = .2


;a1 moogladder ga1, kcutoff, kresonance

;aL, aR reverbsc a1, a1, .72, 5000

;outs ga1, ga1

ga1 = 0

endin


</CsInstruments>
<CsScore>
f1 0 16384 10 1

i3 0 360000

</CsScore>
</CsoundSynthesizer>

