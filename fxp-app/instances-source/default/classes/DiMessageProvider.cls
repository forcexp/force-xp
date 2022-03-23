// DiMessageProvider only exists to be used by InstancesSouerdxce 
public abstract class DiMessageProvider {

	public class InheritedSharingImplementation
			extends DiMessageProvider {
		public InheritedSharingImplementation() { }
	}

	public class WithSharingImplementation
			extends DiMessageProvider {
		public WithSharingImplementation() { }
	}

	public class WithoutSharingImplementation
			extends DiMessageProvider {
		public WithoutSharingImplementation() { }
	}

	public class SomeOtherImplementation
			extends DiMessageProvider {

	}
}
