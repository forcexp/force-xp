public with sharing class InstancesSource {
	@TestVisible
	static final string DEFAULT_WITH_SHARING_CLASSNAME = 'WithSharingImplementation';
	@TestVisible
	static final string DEFAULT_WITHOUT_SHARING_CLASSNAME = 'WithoutSharingImplementation';
	@TestVisible
	static final string DEFAULT_INHERITED_SHARING_CLASSNAME = 'InheritedSharingImplementation';

	public static InstancesSource i {
		get {
			return withSharingInstance;
		}
	}

	public static InstancesSource withSharingInstance {
		get {
			if (withSharingInstance == null) {
				withSharingInstance = new InstancesSource();
			}
			return withSharingInstance;
		}
		private set;
	}

	private  InstancesSource() {
	}

	InstanceManager withSharingInstances {
		get {
			if (withSharingInstances == null) {
				withSharingInstances = new InstanceManager(new WithSharingInstanceTypeProvider());
			}
			return withSharingInstances;
		}
		set;
	}

	InstanceManager withoutSharingInstances {
		get {
			if (withoutSharingInstances == null) {
				withoutSharingInstances = new InstanceManager(new WithoutSharingInstanceTypeProvider());
			}
			return withoutSharingInstances;
		}
		set;
	}

	InstanceManager inheritedSharingInstances {
		get {
			if (inheritedSharingInstances == null) {
				inheritedSharingInstances = new InstanceManager(new inheritedSharingInstanceTypeProvider());
			}
			return inheritedSharingInstances;
		}
		set;
	}

	public Object instanceFor(Type contractType) {
		proceedIfContractTypeHasValue(contractType);

		return withSharingInstances.instanceFor(contractType);
	}

	public Object newInstanceFor(Type contractType) {
		proceedIfContractTypeHasValue(contractType);

		return withSharingInstances.newInstanceFor(contractType);
	}

	public void setWithSharingInstanceTypeFor(Type contractType, Type withSharingInstanceType) {
		proceedIfContractTypeHasValue(contractType);
		proceedIfWithSharingInstanceTypeHasValue(withSharingInstanceType);

		withSharingInstances.setInstanceTypeFor(contractType, withSharingInstanceType);
	}

	public Object withoutSharingInstanceFor(Type contractType) {
		proceedIfContractTypeHasValue(contractType);

		return withoutSharingInstances.instanceFor(contractType);
	}

	public Object newWithoutSharingInstanceFor(Type contractType) {
		proceedIfContractTypeHasValue(contractType);

		return withoutSharingInstances.newInstanceFor(contractType);
	}

	public void setWithoutSharingInstanceTypeFor(Type contractType, Type withoutSharingInstanceType) {
		proceedIfContractTypeHasValue(contractType);
		proceedIfWithoutSharingInstanceTypeHasValue(withoutSharingInstanceType);

		withoutSharingInstances.setInstanceTypeFor(contractType, withoutSharingInstanceType);
	}

	public Object inheritedSharingInstanceFor(Type contractType) {
		proceedIfContractTypeHasValue(contractType);

		return inheritedSharingInstances.instanceFor(contractType);
	}

	public Object newInheritedSharingInstanceFor(Type contractType) {
		proceedIfContractTypeHasValue(contractType);

		return inheritedSharingInstances.newInstanceFor(contractType);
	}

	public void setInheritedSharingInstanceTypeFor(Type contractType, Type inheritedSharingInstanceType) {
		proceedIfContractTypeHasValue(contractType);
		proceedIfInheritedSharingInstanceTypeHasValue(inheritedSharingInstanceType);

		inheritedSharingInstances.setInstanceTypeFor(contractType, inheritedSharingInstanceType);
	}

	private void proceedIfContractTypeHasValue(Type contractType) {
		Arguments.i.proceedIfItHasValue(contractType, 'contractType');
	}

	private void proceedIfWithSharingInstanceTypeHasValue(Type withSharingInstanceType) {
		Arguments.i.proceedIfItHasValue(withSharingInstanceType, 'withSharingInstanceType');
	}

	private void proceedIfWithoutSharingInstanceTypeHasValue(Type withoutSharingInstanceType) {
		Arguments.i.proceedIfItHasValue(withoutSharingInstanceType, 'withoutSharingInstanceType');
	}

	private void proceedIfInheritedSharingInstanceTypeHasValue(Type inheritedSharingInstanceType) {
		Arguments.i.proceedIfItHasValue(inheritedSharingInstanceType, 'inheritedSharingInstanceType');
	}

	class InstanceProvider {
		InstanceTypeProvider withSharingInstanceTypeProvider;
		Map<Type, Object> instanceByContract;

		InstanceProvider(InstanceTypeProvider withSharingInstanceTypeProvider) {
			this.withSharingInstanceTypeProvider = withSharingInstanceTypeProvider;

			instanceByContract = new Map<Type, Object>();
		}

		public Object instanceFor(Type contractType) {
			Object instance = instanceByContract.get(contractType);

			if (instance == null) {
				instance = newInstanceFor(contractType);
				instanceByContract.put(contractType, instance);
			}

			return instance;
		}

		public Object newInstanceFor(Type contractType) {
			Type instanceType = withSharingInstanceTypeProvider.instanceTypeFor(contractType);
			return instanceType.newInstance();
		}
	}

	abstract class InstanceTypeProvider {
		Map<Type, Type> instanceTypeByContract = new Map<Type, Type>();

		public void setInstanceTypeFor(Type contractType, Type newInstanceType) {
			Type instanceType = instanceTypeByContract.get(contractType);
			if (instanceType != null) {
				throw new InstanceTypeAlreadyDefinedException(contractType, instanceType, newInstanceType);
			}

			instanceTypeByContract.put(contractType, newInstanceType);
		}

		public Type instanceTypeFor(Type contractType) {
			Type instanceType = instanceTypeByContract.get(contractType);

			if (instanceType == null) {
				instanceType = defaultInstanceTypeFor(contractType);
				instanceTypeByContract.put(contractType, instanceType);
			}

			return instanceType;
		}

		Type defaultInstanceTypeFor(Type contractType) {
			String defaultInstanceTypeName = defaultInstanceTypeNameFor(contractType);
			Type defaultInstanceType = Type.forName(defaultInstanceTypeName);

			if (defaultInstanceType == null) {
				throw new DefaultInstanceTypeNotFoundException(contractType, defaultInstanceTypeName);
			}

			return defaultInstanceType;
		}

		abstract String defaultInstanceTypeNameFor(Type contractType);
	}

	class WithSharingInstanceTypeProvider
			extends InstanceTypeProvider {

		override String defaultInstanceTypeNameFor(Type contractType) {
			return contractType.getName() + '.' + DEFAULT_WITH_SHARING_CLASSNAME;
		}
	}

	class WithoutSharingInstanceTypeProvider
			extends InstanceTypeProvider {

		override String defaultInstanceTypeNameFor(Type contractType) {
			return contractType.getName() + '.' + DEFAULT_WITHOUT_SHARING_CLASSNAME;
		}
	}

	class InheritedSharingInstanceTypeProvider
			extends InstanceTypeProvider {

		override String defaultInstanceTypeNameFor(Type contractType) {
			return contractType.getName() + '.' + DEFAULT_INHERITED_SHARING_CLASSNAME;
		}
	}

	class InstanceManager {

		InstanceTypeProvider instanceTypeProvider;
		InstanceProvider instanceProvider;

		InstanceManager(InstanceTypeProvider instanceTypeProvider) {
			this.instanceTypeProvider = instanceTypeProvider;
			this.instanceProvider = new InstanceProvider(instanceTypeProvider);
		}

		Object instanceFor(Type contractType) {
			return instanceProvider.instanceFor(contractType);
		}

		Object newInstanceFor(Type contractType) {
			return instanceProvider.newInstanceFor(contractType);
		}

		void setInstanceTypeFor(Type contractType, Type instanceType) {
			instanceTypeProvider.setInstanceTypeFor(contractType, instanceType);
		}

	}

	public abstract class InstancesSourceException
			extends CustomException { }


	public class InstanceTypeAlreadyDefinedException
			extends InstancesSourceException {

		public Type contractType {
			get;
			private set;
		}

		public Type instanceType {
			get;
			private set;
		}

		public Type newInstanceType {
			get;
			private set;
		}

		InstanceTypeAlreadyDefinedException(Type contractType, Type instanceType, Type newInstanceType) {
			this(String.format(
				'Class "{0}" cannot be set as instance type becasuse class "{1}" is already set as instance type for "{2}" contract type.',
				new List<String> {
					newInstanceType.getName(),
					instanceType.getName(),
					contractType.getName()
				}
			));
			this.contractType = contractType;
			this.instanceType = instanceType;
			this.newInstanceType = newInstanceType;
		}
	}

	public class DefaultInstanceTypeNotFoundException
			extends InstancesSourceException {

		public Type contractType {
			get;
			private set;
		}

		public String defaultInstanceTypeName {
			get;
			private set;
		}

		DefaultInstanceTypeNotFoundException(Type contractType, String defaultInstanceTypeName) {
			this(String.format(
				'Cannot provide a default instance type for "{0}" contract type because "{1}" class does not exist or it is not public.',
				new List<String> {
					contractType.getName(),
					defaultInstanceTypeName
				}
			));
			this.contractType = contractType;
			this.defaultInstanceTypeName = defaultInstanceTypeName;
		}
	}
}
