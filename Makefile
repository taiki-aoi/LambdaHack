test: test-short test-medium test-long

test-long: testCampaign testCoop testDefense

test-medium: testCampaign-medium testCoop-medium testDefense-medium

testCampaign:
	dist/build/LambdaHack/LambdaHack --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --gameMode screensaver --frontendStd --stopAfter 500 > /tmp/stdtest.log

testCampaign-medium:
	dist/build/LambdaHack/LambdaHack --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --savePrefix test --gameMode screensaver --frontendStd --stopAfter 60 > /tmp/stdtest.log

testCampaign-frontend:
	dist/build/LambdaHack/LambdaHack --dbgMsgSer --newGame --noMore --maxFps 45 --savePrefix test --gameMode screensaver

testCoop:
	dist/build/LambdaHack/LambdaHack --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --fovMode Permissive --savePrefix test --gameMode testCoop --frontendStd --stopAfter 500 > /tmp/stdtest.log

testCoop-medium:
	dist/build/LambdaHack/LambdaHack --dbgMsgSer --newGame --noMore --noDelay --noAnim --maxFps 100000 --fovMode Shadow --savePrefix test --gameMode testCoop --frontendStd --stopAfter 60 > /tmp/stdtest.log

testCoop-frontend:
	dist/build/LambdaHack/LambdaHack --dbgMsgSer --newGame --noMore --maxFps 180 --fovMode Permissive --savePrefix test --gameMode testCoop

testDefense:
	dist/build/LambdaHack/LambdaHack --dbgMsgSer --newGame --noMore --noAnim --maxFps 100000 --savePrefix test --gameMode testDefense --frontendStd --stopAfter 500 > /tmp/stdtest.log

testDefense-medium:
	dist/build/LambdaHack/LambdaHack --dbgMsgSer --newGame --noMore --maxFps 100000 --savePrefix test --gameMode testDefense --frontendStd --stopAfter 60 > /tmp/stdtest.log

testDefense-frontend:
	dist/build/LambdaHack/LambdaHack --dbgMsgSer --newGame --noMore --maxFps 45 --savePrefix test --gameMode testDefense

test-short: test-short-new test-short-load

test-short-new:
	yes . | dist/build/LambdaHack/LambdaHack --dbgMsgSer --newGame --savePrefix campaign --gameMode campaign --frontendStd --stopAfter 0 > /tmp/stdtest.log
	yes . | dist/build/LambdaHack/LambdaHack --dbgMsgSer --newGame --savePrefix skirmish --gameMode skirmish --frontendStd --stopAfter 0 > /tmp/stdtest.log
	yes . | dist/build/LambdaHack/LambdaHack --dbgMsgSer --newGame --savePrefix PvP --gameMode PvP --frontendStd --stopAfter 0 > /tmp/stdtest.log
	yes . | dist/build/LambdaHack/LambdaHack --dbgMsgSer --newGame --savePrefix Coop --gameMode Coop --frontendStd --stopAfter 0 > /tmp/stdtest.log
	yes . | dist/build/LambdaHack/LambdaHack --dbgMsgSer --newGame --savePrefix defense --gameMode defense --frontendStd --stopAfter 0 > /tmp/stdtest.log
	yes . | dist/build/LambdaHack/LambdaHack --dbgMsgSer --newGame --savePrefix peek --gameMode peek --frontendStd --stopAfter 0 > /tmp/stdtest.log

test-short-load:
	yes . | dist/build/LambdaHack/LambdaHack --dbgMsgSer --savePrefix campaign --gameMode campaign --frontendStd --stopAfter 0 > /tmp/stdtest.log
	yes . | dist/build/LambdaHack/LambdaHack --dbgMsgSer --savePrefix skirmish --gameMode skirmish --frontendStd --stopAfter 0 > /tmp/stdtest.log
	yes . | dist/build/LambdaHack/LambdaHack --dbgMsgSer --savePrefix PvP --gameMode PvP --frontendStd --stopAfter 0 > /tmp/stdtest.log
	yes . | dist/build/LambdaHack/LambdaHack --dbgMsgSer --savePrefix Coop --gameMode Coop --frontendStd --stopAfter 0 > /tmp/stdtest.log
	yes . | dist/build/LambdaHack/LambdaHack --dbgMsgSer --savePrefix defense --gameMode defense --frontendStd --stopAfter 0 > /tmp/stdtest.log
	yes . | dist/build/LambdaHack/LambdaHack --dbgMsgSer --savePrefix peek --gameMode peek --frontendStd --stopAfter 0 > /tmp/stdtest.log

test-travis: test-short test-medium

testPeek-play:
	dist/build/LambdaHack/LambdaHack --dbgMsgSer --savePrefix peek --gameMode peek


# The rest of the makefile is unmaintained at the moment.

default : dist/setup-config
	runghc Setup build

dist/setup-config : LambdaHack.cabal
	runghc Setup configure -fvty --user

vty :
	runghc Setup configure -fvty --user

gtk :
	runghc Setup configure --user

curses :
	runghc Setup configure -fcurses --user

clean :
	runghc Setup clean

ghci :
	ghci -XCPP -idist/build/autogen:Game/LambdaHack
