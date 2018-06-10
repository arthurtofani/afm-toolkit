`rm -rf /home/arthur/tmp/wsp`
Workspace.create("/home/arthur/tmp/wsp", "test")

w = Workspace.load("/home/arthur/tmp/wsp")
w.add_audio("/home/arthur/Documentos/USP/fingerprinting/gtzan/blues/blues.00071.au", "blues.00071.au")

***********

w = Workspace.load("/home/arthur/tmp/wsp")
a = w.audios.first
a.events.add_event(0, "aaa", "33")
a.events.add_event(0, "aaa", "33")
a.events.add_event(0, "aaa", "33")
a.dump

**********************

w = Workspace.load("/home/arthur/tmp/wsp")
a = w.audios.first
aubio = Aubio.new(a)
aubio.run("energy")


*********************


w = Workspace.load("/home/arthur/tmp/wsp")
a = w.audios.first
a.read_info
a.info

**********************

w = Workspace.load("/home/arthur/tmp/wsp")
a = w.audios.first
hfc = NoveltyFunctions::Hfc.new(a, 'test')
hfc.process({})


************

w = Workspace.load("/home/arthur/tmp/wsp")
a = w.audios.first
a.create_degradated_version("test", "pitch", {semitones: 1})

***********

w = Workspace.load("/home/arthur/tmp/wsp")
a = w.audios.first
a.process_onsets("hfc_default", "hfc", {})
a.process_onsets("energy_default", "energy", {})
a2 = a.versions.first
a2.process_onsets("hfc_default", "hfc", {})
a2.process_onsets("energy_default", "energy", {})
x1 = a.onsets["hfc_default"]
x2 = a2.onsets["hfc_default"]
puts "**** HFC ****"
puts Analyzers::OnsetMatcher.new(x1, x2).run(25).stats
puts Analyzers::OnsetMatcher.new(x1.relative_values, x2.relative_values).run(25).stats

x1 = a.onsets["energy_default"]
x2 = a2.onsets["energy_default"]
puts "**** ENERGY ****"
puts Analyzers::OnsetMatcher.new(x1, x2).run(25).stats
puts Analyzers::OnsetMatcher.new(x1.relative_values, x2.relative_values).run(25).stats

***************

w = Workspace.load("/home/arthur/tmp/wsp")
a = w.audios.first
a.create_degradated_version("pitch", "pitch", {semitones: 1})
a2 = a.versions.last
a2.process_onsets("hfc_default", "hfc", {})
a2.process_onsets("energy_default", "energy", {})
x1 = a.onsets["hfc_default"]
x2 = a2.onsets["hfc_default"]
Analyzers::OnsetMatcher.new(x1, x2).run(20).stats
Analyzers::OnsetMatcher.new(x1.relative_values, x2.relative_values).run(20).stats

x1 = a.onsets["energy_default"]
x2 = a2.onsets["energy_default"]
Analyzers::OnsetMatcher.new(x1, x2).run(20).stats
Analyzers::OnsetMatcher.new(x1.relative_values, x2.relative_values).run(20).stats


***************

w = Workspace.load("/home/arthur/tmp/wsp")
a = w.audios.first
a.create_degradated_version("time", "time", {rate: 0.7})
a2 = a.versions.last
a2.process_onsets("hfc_default", "hfc", {})
a2.process_onsets("energy_default", "energy", {})
x1 = a.onsets["hfc_default"]
x2 = a2.onsets["hfc_default"]
Analyzers::OnsetMatcher.new(x1, x2).run(20).stats
Analyzers::OnsetMatcher.new(x1.relative_values, x2.relative_values).run(0.001).stats

x1 = a.onsets["energy_default"]
x2 = a2.onsets["energy_default"]
Analyzers::OnsetMatcher.new(x1, x2).run(20).stats
Analyzers::OnsetMatcher.new(x1.relative_values, x2.relative_values).run(20).stats


*******************

w = Workspace.load("/home/arthur/tmp/wsp")
a = w.audios.first
a.create_degradated_version("time", "time", {rate: 0.95})
a2 = _ #a.versions.last

(0..7).to_a.each do |i|
  a.process_onsets("band#{i}", "echoprint", {subband: i})
  a2.process_onsets("band#{i}", "echoprint", {subband: i})
end
x1 = a.events["band0"]
x2 = a2.events["band0"]
Analyzers::OnsetMatcher.new(x1, x2).run(15).stats


















  agrupado por Grupo de áudios (Músicas, Pássaros, Locução)
    comparação
    |- Degradation D(s)
    |- Event match (precision/recall) (Novelty Function used)
    -eixo x = parâmetro de D que está sendo alterado
