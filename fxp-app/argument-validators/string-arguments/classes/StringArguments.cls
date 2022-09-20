public abstract class StringArguments {

	public static StringArguments i {
		get {
			return withSharingInstance;
		}
	}

	// Classes used by InstancesSource can't rely on InstancesSource.
	public static StringArguments withSharingInstance {
		get {
			if (withSharingInstance == null) {
				withSharingInstance = new WithSharingImplementation();
			}
			return withSharingInstance;
		}
		private set;
	}

	public virtual void proceedIfItHasValue(String argumentValue, String argumentName) {
		throw NotImplementedException.newInstance();
	}

	with sharing class WithSharingImplementation
			extends StringArguments {

		public override void proceedIfItHasValue(String argumentValue, String argumentName) {
			if (String.isBlank(argumentValue)) {
				throw new IllegalArgumentException('ArgumentNull: "' + argumentName + '" argument cannot be null.');
			}
		}
	}
}
