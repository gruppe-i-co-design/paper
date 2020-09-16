# Some planning notes

- [ ] Rewrite methods to explain more our approach to the project as a whole instead of individual algoritms. (Anders)

> The methods section tells readers how you conducted your study. It includes information about your population, sample, methods, and equipment. The “gold standard” of the methods section is that it should enable readers to duplicate your study. Methods sections typically use subheadings; they are written in past tense, and they use a lot of passive voice. This is typically the least read section of an IMRaD report.

- [ ] Write introduction which explains the challange with hardware/software considerations and that we are setting out to explore benefits and disadvantages with different solutions.

> The introduction explains why this research is important or necessary or important. Begin by describing the problem or situation that motivates the research. Move to discussing the current state of research in the field; then reveal a “gap” or problem in the field. Finally, explain how the present research is a solution to that problem or gap. If the study has hypotheses, they are presented at the end of the introduction.

- [ ] Move images into GitHub repo for paper (from Google Drive).

- [ ] Sort and organize links/references used.

- [ ] Write results from odd-even sort.

- [ ] Cleanup results chapter (each subchapter should have similar structure).
	- [ ] Selection sort explanations and figures.
	- [ ] Linear cell sort explanations and figures.

- [ ] Digitize FSMD and ASMD charts for odd-even sort. (Anders)

- [ ] Write discussion topics
	- [ ] Concrete comparison of our algoritms in terms of speed, size (space) and parallelization. Talk about why there was no parallelization in HW implementation of selection sort a lot of parallalization in linear sort.
	- [ ] Comparison of HW and SW implementations in regards to code-, time- and space-complexity (1 paragraph each). Make sure to use concret examples and comparisons from selection, linear and odd-even. Highlight that there are many tradoffs.
		- Code: HW a lot harder (generics, reusing, boilerplate, errors are unclear) and more time consuming. HW longer feedback cycle (syntesizing vs compiling).
		- Time: HW can be parallelized with ease, thus more operations per clock cycle. Parallelization in SW is not trivial and was not attempted due to single core platform. Even though less cycles in HW, is clockspeed faster in SW on prosessor??
		- Space: Parallelized HW can take a lot of space. SW uses fixed space on generic prosessor. HW can have extra memory/state in addition to RAM in circuitry.
	- [ ] The difficulty of IP implementation. Why was the implementation so hard? What issues did we face? What would be the benefit of an IP block?

- [ ] Write conclusion based on discussed topics in discussion. Many tradeoffs between HW and SW.

- [ ] Write abstract.
