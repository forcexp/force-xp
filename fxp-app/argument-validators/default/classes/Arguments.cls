public abstract class Arguments {

	public static Arguments i {
		get {
			return withSharingInstance;
		}
	}

	// Classes used by InstancesSource can't rely on InstancesSource.
	public static Arguments withSharingInstance {
		get {
			if (withSharingInstance == null) {
				withSharingInstance = new WithSharingImplementation();
			}
			return withSharingInstance;
		}
		private set;
	}

	public virtual void proceedIfItHasValue(Object argumentValue, String argumentName) {
		throw NotImplementedException.newInstance();
	}

	with sharing class WithSharingImplementation
			extends Arguments {

		public override void proceedIfItHasValue(Object argumentValue, String argumentName) {
			if (argumentValue == null) {
				throw new IllegalArgumentException('ArgumentNull: "' + argumentName + '" argument cannot be null.');
			}
		}
	}
}
