STEP 1: configure and run ./step1.sh which automates steps 1-4.<br/><br/>
STEP 2: kubectl apply -f step5-enforcers.yaml   #create enforcer group first<br/><br/>
STEP 3: kubectl apply -f step6-scanners.yaml  #replicas set for 3. Adjust as needed and create scanner user first.<br/><br/>

**tested and confirmed with Aqua 5.0.20181 against AKS