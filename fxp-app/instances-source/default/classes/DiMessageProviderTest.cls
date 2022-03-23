@IsTest
public class DiMessageProviderTest {
	@IsTest
	static void ItShouldCreateAnInstance1() {
		System.assert(new DiMessageProvider.WithSharingImplementation() != null);
	}
}
