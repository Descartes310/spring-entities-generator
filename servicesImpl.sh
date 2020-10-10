for entry in "."/*
do
	if [ $entry != "./services.sh" ]
	then
		str_tmp="$(cut -d '/' -f2 <<<"$entry")"
		object="$(cut -d '.' -f1 <<<"$str_tmp")"
		service="$(cut -d '.' -f1 <<<"$str_tmp")ServiceImpl"
		servi="$(cut -d '.' -f1 <<<"$str_tmp")Service"
		repo="$(cut -d '.' -f1 <<<"$str_tmp")Repository"
		objectLowerCase=`echo "$object" | sed -e 's/./\L&/'`
		repoLowerCase=`echo "$repo" | sed -e 's/./\L&/'`
		filename="../../services/implementations/$service.java"
		touch $filename
		echo "$1" >> $filename
		echo -e "\nimport $2.$object;" >> $filename
		echo -e "import java.util.List;" >> $filename
		echo -e "import org.springframework.stereotype.Service;" >> $filename
		echo -e "import com.geloka.api.repositories.$repo;" >> $filename
		echo -e "import com.geloka.api.services.$servi;" >> $filename
		echo -e "\n@Service" >> $filename
		echo -e "public class $service implements $servi{" >> $filename
		echo -e "\n\tprivate $repo $repoLowerCase;" >> $filename
		echo -e "\n\tpublic $service($repo $repoLowerCase) {" >> $filename
		echo -e "\t\tthis.$repoLowerCase = $repoLowerCase;" >> $filename
		echo -e "\t}" >> $filename
		echo -e "\n\t// To save a $object to database\n\t@Override \n\tpublic $object save($object $objectLowerCase) {" >> $filename
		echo -e "\t\treturn this.$repoLowerCase.save($objectLowerCase);" >> $filename
		echo -e "\t}" >> $filename
		echo -e "\n\t// To get all $object's entries from database\n\t@Override \n\tpublic List<$object> findAll() {" >> $filename
		echo -e "\t\treturn this.$repoLowerCase.findAll();" >> $filename
		echo -e "\t}" >> $filename
		echo -e "\n\t// To find $object from database using its identifier\n\t@Override \n\tpublic $object getOne(Long id) {" >> $filename
		echo -e "\t\treturn this.$repoLowerCase.getOne(id);" >> $filename
		echo -e "\t}" >> $filename
		echo -e "\n\t// To delete $object from database using its identifier\n\t@Override \n\tpublic void delete(Long id) {" >> $filename
		echo -e "\t\tthis.$repoLowerCase.deleteById(id);" >> $filename
		echo -e "\t}" >> $filename
		echo -e "\n}" >> $filename
	  	echo "Processing completed !"
	fi
done
