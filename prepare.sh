#!/bin/bash

dir_n=names
if [ ! -d $dir_n ]; then
	mkdir $dir_n
fi

dir_c=config
if [ ! -d $dir_c ]; then
	mkdir $dir_c
fi

echo [vn-past]: Configuration starts.

python - << EOF
from storage import *
dc = DBConfig()
api = PyApi(Config())
mc = MongodController(dc, api)

mc._collNames['equTicker'] = mc._allEquTickers()
print '[MONGOD]: Equity tickers collected.'

mc._collNames['secID'] = mc._allSecIds()
print '[MONGOD]: Security IDs collected.'

mc._collNames['futTicker'] = mc._allFutTickers()
print '[MONGOD]: Future tickers collected.'

mc._collNames['optTicker'] = mc._allOptTickers()
print '[MONGOD]: Option symbols collected.'

mc._collNames['fudTicker'] = mc._allFudTickers()
print '[MONGOD]: Mutual Fund symbols collected.'

mc._collNames['idxTicker'] = mc._allIdxTickers()
print '[MONGOD]: Index symbols collected.'

mc._ensure_index()


EOF

echo [vn-past]: Configuration finished.
echo [vn-past]: Current collection names: 

cd ./names
ls -l