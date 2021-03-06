class Vcsa < Inspec.resource(1)
  name 'vcsa'
	supports platform: 'vsphere'
	desc 'Use the vsphere audit resource to get information from the vSphere API'


## Service checks

  def ssh
    return inspec.backend.api_client(VSphereAutomation::Appliance::AccessSshApi).get.value
  end

  def api_authentication
    inspec.backend.api_client(VSphereAutomation::CIS::SessionApi).get.value.class == VSphereAutomation::CIS::CisSessionInfo ? (return true) : (return false)
  end

  def web_authentication
    begin 
      inspec.backend.vsphere_client('sessionManager').currentSession
      return true
    rescue 
      return false
    end
  end

  def psc_address
    return inspec.backend.api_client(VSphereAutomation::VCenter::SystemConfigPscRegistrationApi).get.value.address
  end

  def sso_domain
    return inspec.backend.api_client(VSphereAutomation::VCenter::SystemConfigPscRegistrationApi).get.value.sso_domain
  end

  def identity_sources
    return inspec.backend.vsphere_client('userDirectory').domainList.reject(&:empty?)
  end

  def consolecli
    return inspec.backend.api_client(VSphereAutomation::Appliance::AccessConsolecliApi).get.value
  end

  def dcui
    return inspec.backend.api_client(VSphereAutomation::Appliance::AccessDcuiApi).get.value
  end

  def shell
    return inspec.backend.api_client(VSphereAutomation::Appliance::AccessShellApi).get.value.enabled
  end

  def timezone
    return inspec.backend.api_client(VSphereAutomation::Appliance::SystemTimeTimezoneApi).get.value
  end

### Health checks

  def system
    return inspec.backend.api_client(VSphereAutomation::Appliance::HealthSystemApi).get.value
  end

  def load
    return inspec.backend.api_client(VSphereAutomation::Appliance::HealthLoadApi).get.value
  end

  def memory
    return inspec.backend.api_client(VSphereAutomation::Appliance::HealthMemApi).get.value
  end

  def service
    return inspec.backend.api_client(VSphereAutomation::Appliance::HealthApplmgmtApi).get.value
  end

  def database
    return inspec.backend.api_client(VSphereAutomation::Appliance::HealthDatabasestorageApi).get.value
  end

  def storage
    return inspec.backend.api_client(VSphereAutomation::Appliance::HealthStorageApi).get.value
  end

  def swap
    return inspec.backend.api_client(VSphereAutomation::Appliance::HealthSwapApi).get.value
  end


## Software checks
  def software
    return inspec.backend.api_client(VSphereAutomation::Appliance::HealthSoftwarepackagesApi).get.value
  end

  def version
    return inspec.backend.api_client(VSphereAutomation::Appliance::SystemVersionApi).get.value.version
  end

  def build
    return inspec.backend.api_client(VSphereAutomation::Appliance::SystemVersionApi).get.value.build
  end

  def auto_update
    return inspec.backend.api_client(VSphereAutomation::Appliance::UpdatePolicyApi).get.value.auto_update
  end

## Networking info

  def hostname
    return inspec.backend.api_client(VSphereAutomation::Appliance::NetworkingApi).get.value.dns.hostname
  end


  def exists?
    return true
  end
end






