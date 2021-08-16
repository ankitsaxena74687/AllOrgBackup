@isTest
public class ParkLocatorTest {
@isTest
    static void testCallout(){
        Test.setMock(WebServiceMock.class,new ParkServiceMock());
        String country='USA';
        System.assertEquals(new List<String>{'Me','You','Him'}, ParkLocator.country(country));
    }
}