
def test_map_py(input):
	m = {}

	import time
	start = time.time()
	c = 0

	locs = {}
	pars = {}
	ranks = {}
	id2ents = {}
	id2pop = {}

	print "+~~~~~~~~"
	
	for l in open(input):

		c = c + 1
		if c%100000 == 0:
			end = time.time()
			print c, "TIME", end-start

		(id, ent, rank, names, parents) = l.rstrip('\n').split('\t')
		rank = rank
		names = names.split(',')
		parents = parents.split(',')

		names.append(ent.split('|')[0])

		added = False
		for name in names:
			name = name.lower()
			#print name
			if name not in locs: locs[name] = {}
			locs[name][id] = "1"
			added = True
			
		if added == True:
			id2pop[id] = len(names)
			for p in parents:
				pars[id + "|" + p] = "1"

			id2ents[id] = ent

			ranks[id] = rank
