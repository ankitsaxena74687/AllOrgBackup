public class UpdateMetadata {
    public static void UpdatePick(){
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();          
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        system.debug('session id:'+UserInfo.getSessionId());
        System.debug(UserInfo.getOrganizationId()+''+UserInfo.getSessionId().SubString(15));
        // Read Custom Field
        
        MetadataService.CustomField customField = (MetadataService.CustomField) service.readMetadata('CustomField', new String[] { 'Account.Active__c' }).getRecords()[0];
        System.debug('customField==='+customField);
        // Add pick list values
        MetadataService.StandardValue sv = new MetadataService.StandardValue();
        sv.fullName = 'Test';
        sv.default_x = false;
        System.debug('sv===='+sv);
       // customField.standardValue.add(sv);
       // List<MetadataService.SaveResult> lstResults = service.updateMetadata( new MetadataService.Metadata[] { customField  });
    }
}