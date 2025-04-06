(cd ~/overlord && sbt compile)
if [ $? -eq 0 ]; then
  (cd ~/overlord && sbt assembly)
  if [ $? -eq 0 ]; then
    java -cp ~/overlord/target/scala-3.3.1/overlord-assembly-1.0.jar Main create template_project.over --board kv260
  fi
fi
