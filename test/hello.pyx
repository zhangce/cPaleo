# distutils: language = c++

def say_hello_to(name):
	print("Hello %s!" % name)

from libcpp.string cimport string
from test.unordered_map cimport unordered_map

def test_map_cmap(input):

	import time
	start = time.time()
	

	cdef unordered_map[string,unordered_map[string,string]] locs = unordered_map[string,unordered_map[string,string]]()
	cdef unordered_map[string,string] pars = unordered_map[string,string]()
	cdef unordered_map[string,string] ranks = unordered_map[string,string]()
	cdef unordered_map[string,string] id2ents = unordered_map[string,string]()
	cdef unordered_map[string,int] id2pop = unordered_map[string,int]()

	print "###########"

	cdef int c = 0
	#cdef bool added = False
	for l in open(input):

		c = c + 1
		if c%100000 == 0:
			end = time.time()
			print c, "TIME", end-start

		(id, ent, rank, names, parents) = l.rstrip('\n').split('\t')
		
		#print id

		rank = rank
		names = names.split(',')
		parents = parents.split(',')

		names.append(ent.split('|')[0])

		added = False
		for name in names:
			name = name.lower()
			if locs.find(name) == locs.end(): locs[name] = unordered_map[string,string]()
			locs[name][id] = "1"
			added = True
		
		if added == True:
			id2pop[id] = len(names)
		
			for p in parents:
				pars[id + "|" + p] = "1"
		
			id2ents[id] = ent
		
			ranks[id] = rank


def test_map_map(input):

	m = {}

	import time
	start = time.time()
	c = 0

	locs = {}
	pars = {}
	ranks = {}
	id2ents = {}
	id2pop = {}

	print "---------"
	
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

