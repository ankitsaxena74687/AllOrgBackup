public class ContactAndLeadSearch {
    
    public static List<List<sObject>> searchContactsAndLeads(String searchword)
    {
        String query='FIND \'' + searchword + '\' IN ALL FIELDS RETURNING Lead(NAme,FirstNAme,LastNAme),Contact(FirstName,LastName)';
        List<List<sObject>> searchConLead = search.query(query);
        return searchConLead;
    }

}