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

	InstanceManager withSharingInstances {
		get {
			if (withSharingInstances == null) {
				withSharingInstances = new InstanceManager(ApexMetadata.SharingModifiers.WITH_SHARING);
			}
			return withSharingInstances;
		}
		set;
	}

	InstanceManager withoutSharingInstances {
		get {
			if (withoutSharingInstances == null) {
				withoutSharingInstances = new InstanceManager(ApexMetadata.SharingModifiers.WITH_SHARING);
			}
			return withoutSharingInstances;
		}
		set;
	}

	InstanceManager inheritedSharingInstances {
		get {
			if (inheritedSharingInstances == null) {
				inheritedSharingInstances = new InstanceManager(ApexMetadata.SharingModifiers.WITH_SHARING);
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

		withSharingInstances.setTypeFor(contractType, withSharingInstanceType);
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

		withoutSharingInstances.setTypeFor(contractType, withoutSharingInstanceType);
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

		inheritedSharingInstances.setTypeFor(contractType, inheritedSharingInstanceType);
	}

	private InstancesSource() {
	}

	void proceedIfInheritedSharingInstanceTypeHasValue(Type inheritedSharingInstanceType) {
		Arguments.i.proceedIfItHasValue(inheritedSharingInstanceType, 'inheritedSharingInstanceType');
	}

	void proceedIfContractTypeHasValue(Type contractType) {
		Arguments.i.proceedIfItHasValue(contractType, 'contractType');
	}

	void proceedIfWithSharingInstanceTypeHasValue(Type withSharingInstanceType) {
		Arguments.i.proceedIfItHasValue(withSharingInstanceType, 'withSharingInstanceType');
	}

	void proceedIfWithoutSharingInstanceTypeHasValue(Type withoutSharingInstanceType) {
		Arguments.i.proceedIfItHasValue(withoutSharingInstanceType, 'withoutSharingInstanceType');
	}

	//class InstanceProvider {
	//	InstanceTypeProvider withSharingInstanceTypeProvider;
	//	Map<Type, Object> instanceByContract;

	//	InstanceProvider(InstanceTypeProvider withSharingInstanceTypeProvider) {
	//		this.withSharingInstanceTypeProvider = withSharingInstanceTypeProvider;

	//		instanceByContract = new Map<Type, Object>();
	//	}

	//	public Object instanceFor(Type contractType) {
	//		Object instance = instanceByContract.get(contractType);

	//		if (instance == null) {
	//			instance = newInstanceFor(contractType);
	//			instanceByContract.put(contractType, instance);
	//		}

	//		return instance;
	//	}

	//	public Object newInstanceFor(Type contractType) {
	//		Type instanceType = withSharingInstanceTypeProvider.instanceTypeFor(contractType);
	//		return instanceType.newInstance();
	//	}
	//}

	//abstract class InstanceTypeProvider {
	//	Map<Type, Type> instanceTypeByContract = new Map<Type, Type>();

	//	public void setInstanceTypeFor(Type contractType, Type newInstanceType) {
	//		instanceTypeByContract.put(contractType, newInstanceType);
	//	}

	//	public Type instanceTypeFor(Type contractType) {
	//		Type instanceType = instanceTypeByContract.get(contractType);

	//		if (instanceType != null) {
	//			return instanceType;
	//		}

	//		// get metadata from CustomMetadata

	//		return defaultInstanceTypeFor(contractType);
	//	}

	//	Type defaultInstanceTypeFor(Type contractType) {
	//		String defaultInstanceTypeName = defaultInstanceTypeNameFor(contractType);
	//		Type defaultInstanceType = Type.forName(defaultInstanceTypeName);

	//		if (defaultInstanceType == null) {
	//			throw new DefaultInstanceTypeNotFoundException(contractType, defaultInstanceTypeName);
	//		}

	//		return defaultInstanceType;
	//	}

	//	abstract String defaultInstanceTypeNameFor(Type contractType);
	//}

	//abstract class InstanceTypeProvider2 {
	//	Map<Type, Type> inApexTransactionTypeOverride = new Map<Type, Type>();

	//	public void setInstanceTypeFor(Type contractType, Type newInstanceType) {
	//		inApexTransactionTypeOverride.put(contractType, newInstanceType);
	//	}

	//	public Type instanceTypeFor(Type contractType) {
	//		if (hasInApexTransactionTypeOverride(contractType)) {
	//			return inApexTransactionTypeFor(contractType);
	//		}

	//		// get metadata from CustomMetadata

	//		if (hasOverrideForTheUser(contractType)) {
	//			return overrideForTheUser(contractType);
	//		}

	//		return defaultInstanceTypeFor(contractType);
	//	}

	//	Boolean hasInApexTransactionTypeOverride(Type contractType) {
	//		return inApexTransactionTypeOverride.keySet().contains(contractType);
	//	}

	//	Type inApexTransactionTypeFor(Type contractType) {
	//		return inApexTransactionTypeOverride.get(contractType);
	//	}

	//	Boolean hasOverrideForTheUser(Type contractType) {
	//		return overrideForTheUser(contractType) != null;
	//	}

	//	Type overrideForTheUser(Type contractType) {

	//		return inApexTransactionTypeOverride.get(contractType);
	//	}


	//	Type overrideFor(Type contractType) {

	//	}



	//	Type defaultInstanceTypeFor(Type contractType) {
	//		String defaultInstanceTypeName = defaultInstanceTypeNameFor(contractType);
	//		Type defaultInstanceType = Type.forName(defaultInstanceTypeName);

	//		if (defaultInstanceType == null) {
	//			throw new DefaultInstanceTypeNotFoundException(contractType, defaultInstanceTypeName);
	//		}

	//		return defaultInstanceType;
	//	}

	//	abstract ApexMetadata.SharingModifiers sharingModifider();

	//	abstract String defaultInstanceTypeNameFor(Type contractType);
	//}

	//class WithSharingInstanceTypeProvider
	//		extends InstanceTypeProvider {

	//	override String defaultInstanceTypeNameFor(Type contractType) {
	//		return contractType.getName() + '.' + DEFAULT_WITH_SHARING_CLASSNAME;
	//	}
	//}

	//class WithoutSharingInstanceTypeProvider
	//		extends InstanceTypeProvider {

	//	override String defaultInstanceTypeNameFor(Type contractType) {
	//		return contractType.getName() + '.' + DEFAULT_WITHOUT_SHARING_CLASSNAME;
	//	}
	//}

	//class InheritedSharingInstanceTypeProvider
	//		extends InstanceTypeProvider {

	//	override String defaultInstanceTypeNameFor(Type contractType) {
	//		return contractType.getName() + '.' + DEFAULT_INHERITED_SHARING_CLASSNAME;
	//	}
	//}

	//class InstanceManager {

	//	InstanceTypeProvider instanceTypeProvider;
	//	InstanceProvider instanceProvider;

	//	InstanceManager(InstanceTypeProvider instanceTypeProvider) {
	//		this.instanceTypeProvider = instanceTypeProvider;
	//		this.instanceProvider = new InstanceProvider(instanceTypeProvider);
	//	}

	//	Object instanceFor(Type contractType) {
	//		return instanceProvider.instanceFor(contractType);
	//	}

	//	Object newInstanceFor(Type contractType) {
	//		return instanceProvider.newInstanceFor(contractType);
	//	}

	//	void setInstanceTypeFor(Type contractType, Type instanceType) {
	//		instanceTypeProvider.setInstanceTypeFor(contractType, instanceType);
	//	}

	// }

	class InstanceManager {
		ApexMetadata.SharingModifiers sharingModifier;
		Map<Type, Type> inApexTransactionTypeOverride = new Map<Type, Type>();
		Map<Type, Object> instanceOverride = new Map<Type, Object>();
		Map<Type, Object> lastCreatedInstances = new Map<Type, Object>();

		public InstanceManager(ApexMetadata.SharingModifiers sharingModifier) {
			this.sharingModifier = sharingModifier;
		}

		public Object instanceFor(Type contractType) {
			if (hasInstanceOverride(contractType)) {
				return instanceOverride(contractType);
			}
			if (hasInstanceCreatedFor(contractType)) {
				return lastCreatedInstanceFor(contractType);
			}
			return createInstanceFor(contractType);
		}

		public Object newInstanceFor(Type contractType) {
			if (hasInstanceOverride(contractType)) {
				return instanceOverride(contractType);
			}
			return createInstanceFor(contractType);
		}

		@TestVisible
		void setTypeFor(Type contractType, Type instanceType) {
			inApexTransactionTypeOverride.put(contractType, instanceType);
		}

		Object createInstanceFor(Type contractType) {
			Object createdInstance;
			if (hasInApexTransactionTypeOverrideFor(contractType)) {
				createdInstance = createInstanceUsingInApexTransactionTypeOverrideFor(contractType);
			}
			else if (hasTypeOverrideFor(contractType)) {
				createdInstance = createInstanceUsingTypeOverrideFor(contractType);
			}
			else {
				createdInstance = createInstanceUsingStandardTypeFor(contractType);
			}
			lastCreatedInstances.put(contractType, createdInstance);
			return createdInstance;
		}

		Boolean hasInApexTransactionTypeOverrideFor(Type contractType) {
			return inApexTransactionTypeOverride.containsKey(contractType);
		}

		Object createInstanceUsingInApexTransactionTypeOverrideFor(Type contractType) {
			Type instanceType = inApexTransactionTypeOverride.get(contractType);
			return instanceType.newInstance();
		}

		Boolean hasTypeOverrideFor(Type contractType) {
			return typeOverrideFor(contractType) != null;
		}

		InstanceTypeOverride__mdt typeOverrideFor(Type contractType) {
			InstanceSourceSettings__mdt instanceSourceSettings = selectInstanceSourceSettings();

			if (instanceSourceSettings == null) {
				return null;
			}

			List<InstanceTypeOverride__mdt> typeOverrideRecords = selectTypeOverride(
				instanceSourceSettings.Id,
				contractType.getName()
			);

			if (typeOverrideRecords.isEmpty()) {
				return null;
			}

			if (hasTypeOverrideThatRequiresCustomPermission(typeOverrideRecords)) {
				List<InstanceTypeOverride__mdt> typeOverrideRecordsForCurrentUser = findTypeOverrideThatMatchesCurrentUserPermissions(typeOverrideRecords);

				if (!typeOverrideRecordsForCurrentUser.isEmpty()) {

					// TODO: generate log entry if typeOverrideRecordsForCurrentUser.size() > 1
					return typeOverrideRecordsForCurrentUser[0];
				}
			}

			if (hasTypeOverrideThatDoesNotRequireCustomPermission(typeOverrideRecords)) {
				List<InstanceTypeOverride__mdt> typeOverrideRecordsThatDontRequireCustomPermissions = findTypeOverrideWhereRequiredCustomPermissionIsBlank(typeOverrideRecords);

				if (!typeOverrideRecordsThatDontRequireCustomPermissions.isEmpty()) {

					// TODO: generate log entry if typeOverrideRecordsThatDontRequireCustomPermissions.size() > 1
					return typeOverrideRecordsThatDontRequireCustomPermissions[0];
				}
			}

			return null;
		}

		InstanceSourceSettings__mdt selectInstanceSourceSettings() {
			List<InstanceSourceSettings__mdt> sourceSettings = [
				SELECT
					OrganizationId__c,
					IsDefault__c
				FROM
					InstanceSourceSettings__mdt
				WHERE
					IsActive__c = TRUE
					AND (
						IsDefault__c = TRUE
						OR OrganizationId__c = :UserInfo.getOrganizationId()
					)
			];

			if (sourceSettings.isEmpty()) {
				return null;
			}

			if (sourceSettings.size() == 1 || sourceSettings[0].OrganizationId__c == UserInfo.getOrganizationId()) {
				return sourceSettings[0];
			}

			return sourceSettings[1];
		}

		List<InstanceTypeOverride__mdt> selectTypeOverride(Id instanceSourceSettingsId, String contractTypeName) {
			List<String> fieldsToSelect = new List<String> {
				InstanceTypeOverride__mdt.BuilderToUse__c.getDescribe().getName()
				,InstanceTypeOverride__mdt.ContractTypeName__c.getDescribe().getName()
				,InstanceTypeOverride__mdt.CustomBuilderType__c.getDescribe().getName()
				,InstanceTypeOverride__mdt.RequiredPermissions__c.getDescribe().getName()
				,InstanceTypeOverride__mdt.InstanceSourceSettings__c.getDescribe().getName()
				,InstanceTypeOverride__mdt.InstanceTypeName__c.getDescribe().getName()
				,InstanceTypeOverride__mdt.OverrideInheritedSharingImplementation__c.getDescribe().getName()
				,InstanceTypeOverride__mdt.OverrideWithoutSharingImplementation__c.getDescribe().getName()
				,InstanceTypeOverride__mdt.OverrideWithSharingImplementation__c.getDescribe().getName()
			};

			SObjectField implementationOptionField;
			switch on sharingModifier {
				when WITH_SHARING {
					implementationOptionField = InstanceTypeOverride__mdt.OverrideWithSharingImplementation__c;
				}
				when WITHOUT_SHARING {
					implementationOptionField = InstanceTypeOverride__mdt.OverrideWithoutSharingImplementation__c;
				}
				when INHERITED_SHARING {
					implementationOptionField = InstanceTypeOverride__mdt.OverrideInheritedSharingImplementation__c;
				}
			}

			List<String> whereExpressions = new List<String> {
				InstanceTypeOverride__mdt.IsActive__c.getDescribe().getName() + ' = TRUE',
				implementationOptionField.getDescribe().getName() + ' = TRUE',
				InstanceTypeOverride__mdt.InstanceSourceSettings__c.getDescribe().getName() + ' = :instanceSourceSettingsId',
				InstanceTypeOverride__mdt.ContractTypeName__c.getDescribe().getName() + ' = :contractTypeName'
			};

			String soql = String.format(
				'SELECT {0} FROM {1} WHERE {2}',
				new List<Object> {
					String.join(fieldsToSelect,','),
					InstanceTypeOverride__mdt.SObjectType.getDescribe().getName(),
					String.join(whereExpressions,' AND ')
				}
			);

			return (List<InstanceTypeOverride__mdt>)Database.query(soql);
		}

		Boolean hasTypeOverrideThatRequiresCustomPermission(List<InstanceTypeOverride__mdt> typeOverrideRecords) {
			for (InstanceTypeOverride__mdt typeOverride: typeOverrideRecords) {
				if (String.isNotBlank(typeOverride.RequiredPermissions__c)) {
					return true;
				}
			}
			return false;
		}

		List<InstanceTypeOverride__mdt> findTypeOverrideThatMatchesCurrentUserPermissions(List<InstanceTypeOverride__mdt> typeOverrideRecords) {
			List<InstanceTypeOverride__mdt> result = new List<InstanceTypeOverride__mdt>();

			for(InstanceTypeOverride__mdt typeOverrideRecord: typeOverrideRecords) {
				if (String.isBlank(typeOverrideRecord.RequiredPermissions__c)) {
					continue;
				}

				List<String> customPermissions = typeOverrideRecord.RequiredPermissions__c.split('\n');

				Boolean selectRecord = true;
				for(String customPermission: customPermissions) {
					// TODO: find a way to avoid customPermission = '' otherwise FeatureManagement.CustomPermission will throw the error bellow:
					// |FATAL_ERROR|System.UnexpectedException: Salesforce System Error: 1656269696-301606 (1627007421) (1627007421)
					if (!FeatureManagement.checkPermission(customPermission)) {
						selectRecord = false;
						break;
					}
				}

				if (selectRecord) {
					result.add(typeOverrideRecord);
				}
			}

			return sortTypeOverrideByNumberOfRequiredPermissionsDescending(result);
		}

		/**
		 * @description this method is intended to sort a list of InstanceTypeOverride__mdt
		 * based on the number of required permissions in descended order.
		 * The InstanceTypeOverride__mdt that requires more permissions to be applied have
		 * more weight over those that have fewer required permissions.
		 */
		@TestVisible
		List<InstanceTypeOverride__mdt> sortTypeOverrideByNumberOfRequiredPermissionsDescending(List<InstanceTypeOverride__mdt> typeOverrideRecords) {
			Map<Integer, List<InstanceTypeOverride__mdt>> typeOverrideGroupedByNumberOfRequiredPermissions = new Map<Integer, List<InstanceTypeOverride__mdt>>();

			for(InstanceTypeOverride__mdt record: typeOverrideRecords) {
				Integer numberOfRequiredPermissions = record.RequiredPermissions__c.split('\n').size();

				if (!typeOverrideGroupedByNumberOfRequiredPermissions.containsKey(numberOfRequiredPermissions)) {
					typeOverrideGroupedByNumberOfRequiredPermissions.put(numberOfRequiredPermissions, new List<InstanceTypeOverride__mdt>());
				}

				typeOverrideGroupedByNumberOfRequiredPermissions.get(numberOfRequiredPermissions).add(record);
			}

			List<Integer> quantities = new List<Integer>(typeOverrideGroupedByNumberOfRequiredPermissions.keySet());
			quantities.sort();

			List<InstanceTypeOverride__mdt> result = new List<InstanceTypeOverride__mdt>();
			for(Integer index = quantities.size() - 1; index > -1; index--) {
				Integer numberOfRequiredPermissions = quantities[index];
				result.addAll(typeOverrideGroupedByNumberOfRequiredPermissions.get(numberOfRequiredPermissions));
			}

			return result;
		}

		Boolean hasTypeOverrideThatDoesNotRequireCustomPermission(List<InstanceTypeOverride__mdt> typeOverrideRecords) {
			for (InstanceTypeOverride__mdt typeOverride: typeOverrideRecords) {
				if (String.isBlank(typeOverride.RequiredPermissions__c)) {
					return true;
				}
			}
			return false;
		}


		List<InstanceTypeOverride__mdt> findTypeOverrideWhereRequiredCustomPermissionIsBlank(List<InstanceTypeOverride__mdt> typeOverrideRecords) {
			List<InstanceTypeOverride__mdt> result = new List<InstanceTypeOverride__mdt>();

			for(InstanceTypeOverride__mdt record: typeOverrideRecords) {
				Boolean selectRecord = String.isBlank(record.RequiredPermissions__c);

				if (selectRecord) {
					result.add(record);
				}
			}

			return result;
		}

		Object createInstanceUsingTypeOverrideFor(Type contractType) {
			InstanceTypeOverride__mdt typeOverride = typeOverrideFor(contractType);
			return createInstanceUsingTypeOverride(typeOverride);
		}

		Object createInstanceUsingTypeOverride(InstanceTypeOverride__mdt typeOverride) {
			if (typeOverride.BuilderToUse__c == 'Standard') {
				Type instanceType = typeForClassName(
					typeOverride.InstanceTypeName__c
				);
				return instanceType.newInstance();
			}

			Type customBuilderType = typeForClassName(
				typeOverride.CustomBuilderType__c
			);
			if (!IBuilder.class.isAssignableFrom(customBuilderType)) {
				throw new InvalidCustomBuilderTypeException(
					'"' + customBuilderType.getName() + ' custom builder type do not implement "' + IBuilder.class.getName() + '"'
					+ ' so it cannot be used as a Builder. InstanceTypeOverride__mdt Id: ' + InstanceTypeOverride__mdt.Id
				);
			}
			IBuilder builder = (IBuilder)customBuilderType.newInstance();
			return builder.build();
		}

		Object createInstanceUsingStandardTypeFor(Type contractType) {
			Type instanceType = standardTypeFor(contractType);
			return instanceType.newInstance();
		}

		Type standardTypeFor(Type contractType) {
			String typeName = standardTypeNameFor(contractType);
			Type instanceType = typeForClassName(typeName, contractType);
			return instanceType;
		}

		Type typeForClassName(String className) {
			Type result = Type.forName(className);
			if (result == null) {
				throw newClassNotFoundException(className);
			}
			return result;
		}

		Type typeForClassName(String className, Type contractType) {
			Type result = Type.forName(className);
			if (result == null) {
				throw new InstanceTypeNotFoundException(contractType, className);
			}
			return result;
		}

		String standardTypeNameFor(Type contractType) {
			String standardTypeName = contractType.getName() + '.';
			switch on sharingModifier {
				when WITH_SHARING {
					standardTypeName += DEFAULT_WITH_SHARING_CLASSNAME;
				}
				when WITHOUT_SHARING {
					standardTypeName += DEFAULT_WITHOUT_SHARING_CLASSNAME;
				}
				when INHERITED_SHARING {
					standardTypeName += DEFAULT_INHERITED_SHARING_CLASSNAME;
				}
			}
			return standardTypeName;
		}

		Boolean hasInstanceCreatedFor(Type contractType) {
			return lastCreatedInstances.containsKey(contractType);
		}

		Object lastCreatedInstanceFor(Type contractType) {
			return lastCreatedInstances.get(contractType);
		}

		@TestVisible
		void overrideInstanceFor(Type contractType, Object instance) {
			instanceOverride.put(contractType, instance);
		}

		Boolean hasInstanceOverride(Type contractType) {
			return instanceOverride.containsKey(contractType);
		}

		Object instanceOverride(Type contractType) {
			return instanceOverride.get(contractType);
		}

		ClassNotFoundException newClassNotFoundException(String className) {
			ClassNotFoundException e = new ClassNotFoundException(String.format(
				'Class type cannot be created because "{0}" class does not exist or it is not public.',
				new List<String> {
					className
				}
			));
			e.className = className;

			return e;
		}
	}

	public abstract class InstancesSourceException
			extends CustomException { }


	public class InvalidCustomBuilderTypeException extends InstancesSourceException { }

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

	public class ClassNotFoundException
			extends InstancesSourceException {

		public String className {
			get;
			private set;
		}
	}

	public class InstanceTypeNotFoundException
			extends InstancesSourceException {

		public Type contractType {
			get;
			private set;
		}

		public String instanceTypeName {
			get;
			private set;
		}

		InstanceTypeNotFoundException(Type contractType, String instanceTypeName) {
			this(String.format(
				'Cannot provide an instance type for "{0}" contract type because "{1}" class does not exist or it is not public.',
				new List<String> {
					contractType.getName(),
					instanceTypeName
				}
			));
			this.contractType = contractType;
			this.instanceTypeName = instanceTypeName;
		}
	}

	public interface IBuilder {
		Object build();
	}
}
