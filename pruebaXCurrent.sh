#!/bin/bash
clear
echo "Automatized xcurrent....."

echo "Automatized xcurrent"
sudo tar -xvf xcurrent-v4.4.2.tar.gz							#Descomprimir el xcurrent.zip

echo "Give permissions"
sudo chmod 777 xcurrent-server-4.4.2/							#Añadir archivos a sus correspondientes carpetas
sudo chmod 777 xcurrent-server-4.4.2/lib/
sudo chmod 777 xcurrent-server-4.4.2/etc/
sudo chmod 777 xcurrent-schema-4.4.0/
	
	echo "Add ripplenet-keytool-1.1.0.jar to folder"
	sudo cp  -f ripplenet-keytool-1.1.0.jar ./xcurrent-server-4.4.2/lib/		#añadir el jar a la carpeta correspondiente
		
		echo "Access to the folder"				
		cd xcurrent-server-4.4.2/lib						#Acceder a la carpeta
 		echo "Execute the  ripplenet.jar"
		java -jar ripplenet-keytool-1.1.0.jar					#Ejecutar el jar
		echo "jar executed"
			#Archivo rn-keystore.pkcs12(generado  en la carpeta lib ) añadirlo a la carpeta xcurrent-server-4.4.2 y a la 				xcurrent-server-4.4.2/etc
			echo "Add rn.keystore to folder xcurrent-server-4.4.2/etc"
			sudo cp -f rn-keystore.pkcs12 ../etc/ 				#añadir el pkcs12 a la carpeta correspondiente

			echo "Add rn.keystore to folder xcurrent-server-4.4.2"
			sudo cp -f rn-keystore.pkcs12 ../				#añadir el pkcs12 a la carpeta correspondiente

	
	echo "Return to the principal folder"
	cd ../..
									
	echo "Add service.settings to folder"
	sudo cp -f service.settings ./xcurrent-server-4.4.2/bin/			#añadir el service.settings a la carpeta 												xcurrent-server-4.4.2/bin

	echo "Add dockerfile to folder"
	sudo cp -f Dockerfile ./xcurrent-server-4.4.2/					#añadir el Dockerfile a la carpeta 												xcurrent-server-4.4.2

	echo "Add xcurrent.properties to folder"
	sudo cp -f xcurrent.properties ./xcurrent-server-4.4.2/etc/  #Copy the file in relative path, the '-f' consist of force de overwritting
	
	echo "We access the carperta necessary to modify"
	cd xcurrent-server-4.4.2/etc/
		
		echo "Get ip value"							
		ip="$(hostname -I | cut -d' ' -f1)"					#Obtenemos nuestra ip
		echo "The ip is as follows: "$ip
		sudo sed -i "s/ipnew/$ip/g" "xcurrent.properties"			#Modificamos el archivo para añadir nuestra ip



	echo "Return to the principal folder"
	cd ../..

	echo "We modify the docker compose"
	replace=.0
	subnet=$ip | sed "s/.7/${replace}/"
	#subnet="$({$ip/.7/.0})"								
	sudo sed -i "s/ipsubnet/$subnet/g" "docker-compose.yml"				#modifica el docker-compose para añadir la subnet
	sudo sed -i "s/ipnew/$ip/g" "docker-compose.yml"				#modifica el docker-compose para añadir la subnet
	
	echo "We clean the docker compose"
	#sudo docker system prune -a							#Limpiamos por posibles colisiones

	echo "We run the docker compose"						#Levantamos  el dockercompose
	#sudo docker-compose -f docker-compose.yml up
	
	


