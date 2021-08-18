@isTest
private class AnimalLocatorTest {
    @isTest static void AnimalLocatorMock1(){
        Test.setMock(HttpCallOutMock.class,new AnimalLocatorMock());
        String result =AnimalLocator.getAnimalNameById(3);
        String expres='cow';
        System.assertEquals(result,expres);
    }

}