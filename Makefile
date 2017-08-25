getmpk:
	# curl -O https://github.com/mendix/IBM-Watson-Connector-Suite/raw/master/IBM%20Watson%20Connectors%20Example%20Project.mpr master.
	# curl -o master.zip https://github.com/mendix/IBM-Watson-Connector-Suite/archive/master.zip
	# curl -o simon.zip https://github.com/simo101/IBM-Watson-Connector-Kit/archive/master.zip
	mkdir -p mpk

	wget https://github.com/mendix/IBM-Watson-Connector-Suite/archive/master.zip -O mpk/master.zip
	cd mpk && unzip master.zip && cd IBM-Watson-Connector-Suite-master && zip ../master.mpk * -r
	rm -rf mpk/IBM-Watson-Connector-Suite-master

	wget https://github.com/simo101/IBM-Watson-Connector-Kit/archive/Conversation_Context.zip  -O mpk/target.zip
	cd mpk && unzip target.zip &&	cd IBM-Watson-Connector-Kit-Conversation_Context && zip ../target.mpk * -r
	rm -rf mpk/IBM-Watson-Connector-Kit-Conversation_Context

justrun: getmpk
	MXPROJECT_NAME=myapp  MXTEMPLATE_MPK=mpk/master.mpk node index.js > origin.txt
	MXPROJECT_NAME=mytarget  MXTEMPLATE_MPK=mpk/target.mpk node index.js > target.txt


run:
	run.sh


buildjs:
	tsc
