package crowdera

import grails.transaction.Transactional
import org.jets3t.service.impl.rest.httpclient.RestS3Service
import org.jets3t.service.model.S3Bucket
import org.jets3t.service.model.S3Object
import org.jets3t.service.security.AWSCredentials
import org.springframework.web.multipart.commons.CommonsMultipartFile;

@Transactional
class FileUtilService {

    String uploadFile(CommonsMultipartFile multipartFile, def bucketName, def folder) {
        
        String fileUrl;
        
        if (!multipartFile?.empty) {
            
            String awsSecretKey = grailsApplication.config.aws.secretKey
            String awsAccessKey = grailsApplication.config.aws.accessKey

            def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
            def s3Service = new RestS3Service(awsCredentials);
            def s3Bucket = new S3Bucket(bucketName)

            int index = multipartFile.getOriginalFilename().lastIndexOf(".")
            String extName = multipartFile.getOriginalFilename().substring(index);
            def fileName =  UUID.randomUUID().toString() + extName
            
            def tempFile = new File("${fileName}")
            def key = "${folder}/${fileName}"
            
            key = key.toLowerCase()
            multipartFile.transferTo(tempFile)
            
            def object = new S3Object(tempFile)
            object.key = key

            s3Service.putObject(s3Bucket, object)
            tempFile.delete()

            fileUrl = "//s3.amazonaws.com/crowdera/${key}"
        }
        
        return fileUrl;
    }
}
