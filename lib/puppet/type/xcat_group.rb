# This has to be a separate type to enable collecting
Puppet::Type.newtype(:xcat_group) do
  @doc = 'group - a logical object definition in the xCAT database.'

  ensurable
  
  newparam(:groupname, :namevar=>true) do
    desc '(nodegroup.groupname) Name of the group.'
  end

  newparam(:addkmdline) do
    desc '(bootparams.addkcmdline) User specified one or more parameters to be passed to the kernel'
  end
  
  newproperty(:usercomment) do 
    desc 'Any user-written notes.'
  end

  newproperty(:auth) do
    desc '(nodetype.arch) The hardware architecture of this node. Valid values: x86_64, ppc64, x86, ia64.'
    newvalues(:x86_64, :ppc64, :x86, :ia64)
  end

  newproperty(:authdomain) do
    desc '(domain.authdomain) If a node should participate in an AD domain or Kerberos realm distinct from domain indicated in site, this field can be used to specify that'
  end

  newproperty(:bmc) do
    desc '(ipmi.bmc) The hostname of the BMC adapater.'
  end

  newproperty(:bmcpassword) do
    desc '(ipmi.password) The BMC password. If not specified, the key=ipmi row in the passwd table is used as the default.'
  end

  newproperty(:bmcport) do
    desc '(ipmi.bmcport) In systems with selectable shared/dedicated ethernet ports, this parameter can be used to specify the preferred port. 0 means use the shared port, 1 means dedicated, blank is to not assign'
  end

  newproperty(:bmcusername) do
    desc '(ipmi.username) The BMC userid. If not specified, the key=ipmi row in the passwd table is used as the default.'
  end

  newproperty(:cfgmgr) do
    desc '(cfgmgt.cfgmgr) The name of the configuration manager service. Currently \'chef\' and \'puppet\' are supported services.'
  end

  newproperty(:cfgmgtroles) do
    desc '(cfgmgt.roles) The roles associated with this node as recognized by the cfgmgr for the software that is to be installed and configured. These role names map to chef recipes or puppet manifest classes that should be used for this node. For example, chef OpenStack cookbooks have roles such as mysql-master,keystone, glance, nova-controller, nova-conductor, cinder-all.'
  end

  newproperty(:cfgserver) do
    desc '(cfgmgt.cfgserver) The xCAT node name of the chef server or puppet master'
  end

  newproperty(:chain) do
    desc '(chain.chain) A comma-delimited chain of actions to be performed automatically when this node is discovered. ("Discovered" means a node booted, but xCAT and DHCP did not recognize the MAC of this node. In this situation, xCAT initiates the discovery process, the last step of which is to run the operations listed in this chain attribute, one by one.) Valid values: boot or reboot, install or netboot, runcmd=<cmd>, runimage=<URL>, shell, standby. (Default - same as no chain - it will do only the discovery.). Example, for BMC machines use: runcmd=bmcsetup,shell.'
  end

  newproperty(:chassis) do
    desc '(nodepos.chassis) The BladeCenter chassis the blade is in.'
  end

  newproperty(:cmdmapping) do
    desc '(nodehm.cmdmapping) The fully qualified name of the file that stores the mapping between PCM hardware management commands and xCAT/third-party hardware management commands for a particular type of hardware device. Only used by PCM.'
  end

  newproperty(:cons) do
    desc '(nodehm.cons) The console method. If nodehm.serialport is set, this will default to the nodehm.mgt setting, otherwise it defaults to unused. Valid values: cyclades, mrv, or the values valid for the mgt attribute.'
  end

  newproperty(:conserver) do
    desc '(nodehm.conserver) The hostname of the machine where the conserver daemon is running. If not set, the default is the xCAT management node.'
  end

  newproperty(:cpucount) do
    desc '(hwinv.cpucount) The number of cpus for the node.'
  end

  newproperty(:cputype) do
    desc '(hwinv.cputype) The cpu model name for the node.'
  end

  newproperty(:dhcpinterfaes) do
    desc '(servicenode.dhcpinterfaces) The network interfaces DHCP server should listen on for the target node. This attribute can be used for management node and service nodes. If defined, it will override the values defined in site.dhcpinterfaces. This is a comma separated list of device names. !remote! indicates a non-local network for relay DHCP. For example: !remote!,eth0,eth1'
  end

  newproperty(:disksize) do
    desc '(hwinv.disksize) The size of the disks for the node.'
  end

  newproperty(:displayname) do
    desc '(mpa.displayname) Alternative name for BladeCenter chassis. Only used by PCM.'
  end

  newproperty(:domainadminpassword) do
    desc '(domain.adminpassword) Allow a node specific indication of Administrative user password for the domain. Most will want to ignore this in favor of passwd table.'
  end

  newproperty(:domainadminuser) do
    desc '(domain.adminuser) Allow a node specific indication of Administrative user. Most will want to just use passwd table to indicate this once rather than by node.'
  end

  newproperty(:domaintype) do
    desc '(domain.type) Type, if any, of authentication domain to manipulate. The only recognized value at the moment is activedirectory.'
  end

  newproperty(:getmac) do
    desc '(nodehm.getmac) The method to use to get MAC address of the node with the getmac command. If not set, the mgt attribute will be used. Valid values: same as values for mgmt attribute.'
  end

  newproperty(:grouptype) do
    desc '(nodegroup.grouptype) The only current valid value is dynamic. We will be looking at having the object def commands working with static group definitions in the nodelist table.'
  end

  newproperty(:hcp) do
    desc '(ppc.hcp, zvm.hcp) The hardware control point for this node (HMC, IVM, Frame or CEC). Do not need to set for BPAs and FSPs.

    or
    
    The hardware control point for this node.'
  end

  newproperty(:height) do
    desc '(nodepos.height) The server height in U(s).'
  end

  newproperty(:hostcluster) do
    desc 'Specify to the underlying virtualization infrastructure a cluster membership for the hypervisor.'
  end

  newproperty(:hostinterface) do
    desc '(hypervisor.interface) The definition of interfaces for the hypervisor. The format is [networkname:interfacename:bootprotocol:IP:netmask:gateway] that split with | for each interface'
  end

  newproperty(:hostmanager) do
    desc '(hypervisor.mgr) The virtualization specific manager of this hypervisor when applicable'
  end

  newproperty(:hostnames) do
    desc '(hosts.hostnames) Hostname aliases added to /etc/hosts for this node. Comma or blank separated list.'
  end

  newproperty(:hosttype) do
    desc '(hypervisor.type) The plugin associated with hypervisor specific commands such as revacuate'
  end

  newproperty(:hwtype) do
    desc <<-eos 
    (ppc.nodetype, zvm.nodetype, mp.nodetype, mic.nodetype) The hardware type of the node. Only can be one of fsp, bpa, cec, frame, ivm, hmc and lpar

    or
    
    The node type. Valid values: cec (Central Electronic Complex), lpar (logical partition), zvm (z/VM host operating system), and vm (virtual machine).
    
    or
    
    The hardware type for mp node. Valid values: mm,cmm, blade.
    
    or
    
    The hardware type of the mic node. Generally, it is mic.'
    eos
  end

  newproperty(:id) do
    desc <<-eos 
    (ppc.id, mp.id) For LPARs: the LPAR numeric id; for CECs: the cage number; for Frames: the frame number.

    or
    
    The slot number of this blade in the BladeCenter chassis.'
    eos
  end

  newproperty(:initrd) do
    desc '(bootparams.initrd) The initial ramdisk image that network boot actions should use (could be a DOS floppy or hard drive image if using memdisk as kernel)'
  end

  newproperty(:installnic) do
    desc '(noderes.installnic) The network adapter on the node that will be used for OS deployment, the installnic can be set to the network adapter name or the mac address or the keyword "mac" which means that the network interface specified by the mac address in the mac table will be used. If not set, primarynic will be used.'
  end

  newproperty(:interface) do
    desc '(mac.interface) The adapter interface name that will be used to install and manage the node. E.g. eth0 (for linux) or en0 (for AIX).)'
  end

  newproperty(:ip) do
    desc '(hosts.ip) The IP address of the node. This is only used in makehosts. The rest of xCAT uses system name resolution to resolve node names to IP addresses.'
  end

  newproperty(:iscsipassword) do
    desc '(iscsi.passwd) The password for the iscsi server containing the boot device for this node.'
  end

  newproperty(:iscsiserver) do
    desc '(iscsi.server) The server containing the iscsi boot device for this node.'
  end

  newproperty(:iscsitarget) do
    desc '(iscsi.target) The iscsi disk used for the boot device for this node. Filled in by xCAT.'
  end

  newproperty(:iscsiuserid) do
    desc '(iscsi.userid) The userid of the iscsi server containing the boot device for this node.'
  end

  newproperty(:kcmdline) do
    desc '(bootparams.kcmdline) Arguments to be passed to the kernel'
  end

  newproperty(:kernel) do
    desc '(bootparams.kernel) The kernel that network boot actions should currently acquire and use. Note this could be a chained boot loader such as memdisk or a non-linux boot loader'
  end
  
  newproperty(:mac) do
    desc '(mac.mac) The mac address or addresses for which xCAT will manage static bindings for this node. This may be simply a mac address, which would be bound to the node name (such as "01:02:03:04:05:0E"). This may also be a "|" delimited string of "mac address!hostname" format (such as "01:02:03:04:05:0E!node5|01:02:03:05:0F!node6-eth1").'
  end
  
  newproperty(:membergroups) do
    desc '(nodegroup.membergroups) This attribute stores a comma-separated list of nodegroups that this nodegroup refers to. This attribute is only used by PCM.'
  end
  
  newproperty(:members) do
    desc '(nodegroup.members) The value of the attribute is not used, but the attribute is necessary as a place holder for the object def commands. (The membership for static groups is stored in the nodelist table.)'
  end
  
  newproperty(:memory) do
    desc '(hwinv.memory) The size of the memory for the node.'
  end
  
  newproperty(:mgt) do
    desc '(nodehm.mgt) The method to use to do general hardware management of the node. This attribute is used as the default if power or getmac is not set. Valid values: ipmi, blade, hmc, ivm, fsp, bpa, kvm, esx, rhevm. See the power attribute for more details.'
  end
  
  newproperty(:micbridge) do
    desc '(mic.bridge) The virtual bridge on the host node which the mic connected to.'
  end
  
  newproperty(:michost) do
    desc '(mic.host) The host node which the mic card installed on.'
  end
  
  newproperty(:micid) do
    desc '(mic.id) The device id of the mic node.'
  end
  
  newproperty(:miconboot) do
    desc '(mic.onboot) Set mic to autoboot when mpss start. Valid values: yes|no. Default is yes.'
  end
  
  newproperty(:micpowermgt) do
    desc '(mic.powermgt) Set the Power Management for mic node. This attribute is used to set the power management state that mic may get into when it is idle. Four states can be set: cpufreq, corec6, pc3 and pc6. The valid value for powermgt attribute should be [cpufreq=<on|off>]![corec6=<on|off>]![pc3=<on|off>]![pc6=<on|off>]. e.g. cpufreq=on!corec6=off!pc3=on!pc6=off. Refer to the doc of mic to get more information for power management.'
  end
  
  newproperty(:micvlog) do
    desc '(mic.vlog) Set the Verbose Log to console. Valid values: yes|no. Default is no.'
  end
  
  newproperty(:migrationdest) do
    desc '(vm.migrationdest) A noderange representing candidate destinations for migration (i.e. similar systems, same SAN, or other criteria that xCAT can use'
  end
  
  newproperty(:monserver) do
    desc '(noderes.monserver) The monitoring aggregation point for this node. The format is "x,y" where x is the ip address as known by the management node and y is the ip address as known by the node.'
  end
  
  newproperty(:mpa) do
    desc '(mp.mpa) The managment module used to control this blade.'
  end
  
  newproperty(:mtm) do
    desc '(vpd.mtm) The machine type and model number of the node. E.g. 7984-6BU'
  end
  
  newproperty(:nameservers) do
    desc '(noderes.nameservers) An optional node/group specific override for name server list. Most people want to stick to site or network defined nameserver configuration.'
  end
  
  newproperty(:netboot) do
    desc '(noderes.netboot) The type of network booting to use for this node. Valid values: pxe or xnba for x86* architecture, yaboot for POWER architecture.'
  end
  
  newproperty(:nfsdir) do
    desc '(noderes.nfsdir) The path that should be mounted from the NFS server.'
  end
  
  newproperty(:nfsserver) do
    desc '(noderes.nfsserver) The NFS or HTTP server for this node (as known by this node).'
  end
  
  newproperty(:nicaliases) do
    desc <<-eos 
    (nics.nicaliases) Comma-separated list of hostname aliases for each NIC.
    Format: eth0!<alias list>,eth1!<alias1 list>|<alias2 list>
                For multiple aliases per nic use a space-separated list.
    For example: eth0!moe larry curly,eth1!tom|jerry'
    eos
  end
  
  newproperty(:niccustomscripts) do
    desc '(nics.niccustomscripts) Comma-separated list of custom scripts per NIC. <nic1>!<script1>,<nic2>!<script2>, e.g. eth0!configeth eth0, ib0!configib ib0. The xCAT object definition commands support to use niccustomscripts.<nicname> as the sub attribute'
  end
  
  newproperty(:nichostnameprefixes) do
    desc <<-eos
    (nics.nichostnameprefixes)
    Comma-separated list of hostname prefixes per NIC.
  
                      If only one ip address is associated with each NIC:
                          <nic1>!<ext1>,<nic2>!<ext2>,..., for example, eth0!eth0-,ib0!ib-
                      If multiple ip addresses are associcated with each NIC:
                          <nic1>!<ext1>|<ext2>,<nic2>!<ext1>|<ext2>,..., for example,  eth0!eth0-|eth0-ipv6i-,ib0!ib-|ib-ipv6-.
                      The xCAT object definition commands support to use nichostnameprefixes.<nicname> as the sub attributes.
                      Note:  According to DNS rules a hostname must be a text string up to 24 characters drawn from the alphabet (A-Z), digits (0-9), minus sign (-),and period (.). When you are specifying "nichostnameprefixes" or "nicaliases" make sure the resulting hostnames will conform to this naming convention
    eos
  end
  
  newproperty(:nichostnamesuffixes) do
    desc <<-eos
    (nics.nichostnamesuffixes)
    Comma-separated list of hostname suffixes per NIC.
  
                      If only one ip address is associated with each NIC:
                          <nic1>!<ext1>,<nic2>!<ext2>,..., for example, eth0!-eth0,ib0!-ib0
                      If multiple ip addresses are associcated with each NIC:
                          <nic1>!<ext1>|<ext2>,<nic2>!<ext1>|<ext2>,..., for example,  eth0!-eth0|-eth0-ipv6,ib0!-ib0|-ib0-ipv6.
                      The xCAT object definition commands support to use nichostnamesuffixes.<nicname> as the sub attributes.
                      Note:  According to DNS rules a hostname must be a text string up to 24 characters drawn from the alphabet (A-Z), digits (0-9), minus sign (-),and period (.). When you are specifying "nichostnamesuffixes" or "nicaliases" make sure the resulting hostnames will conform to this naming convention
    eos
  end
  
  newproperty(:nicips) do
    desc <<-eos
    (nics.nicips)
    Comma-separated list of IP addresses per NIC. To specify one ip address per NIC:
  
                  <nic1>!<ip1>,<nic2>!<ip2>,..., for example, eth0!10.0.0.100,ib0!11.0.0.100
              To specify multiple ip addresses per NIC:
                  <nic1>!<ip1>|<ip2>,<nic2>!<ip1>|<ip2>,..., for example, eth0!10.0.0.100|fd55::214:5eff:fe15:849b,ib0!11.0.0.100|2001::214:5eff:fe15:849a. The xCAT object definition commands support to use nicips.<nicname> as the sub attributes.
              Note: The primary IP address must also be stored in the hosts.ip attribute. The nichostnamesuffixes should specify one hostname suffix for each ip address.
    eos
  end
  
  newproperty(:nicnetworks) do
    desc <<-eos
    (nics.nicnetworks)
    Comma-separated list of networks connected to each NIC.
  
              If only one ip address is associated with each NIC:
                  <nic1>!<network1>,<nic2>!<network2>, for example, eth0!10_0_0_0-255_255_0_0, ib0!11_0_0_0-255_255_0_0
              If multiple ip addresses are associated with each NIC:
                  <nic1>!<network1>|<network2>,<nic2>!<network1>|<network2>, for example, eth0!10_0_0_0-255_255_0_0|fd55:faaf:e1ab:336::/64,ib0!11_0_0_0-255_255_0_0|2001:db8:1:0::/64. The xCAT object definition commands support to use nicnetworks.<nicname> as the sub attributes.
    eos
  end
  
  newproperty(:nictypes) do
    desc '(nics.nictypes) Comma-separated list of NIC types per NIC. <nic1>!<type1>,<nic2>!<type2>, e.g. eth0!Ethernet,ib0!Infiniband. The xCAT object definition commands support to use nictypes.<nicname> as the sub attributes.'
  end
  
  newproperty(:nimserver) do
    desc '(noderes.nimserver) Not used for now. The NIM server for this node (as known by this node).'
  end
  
  newproperty(:nodetype) do
    desc '(nodetype.nodetype) A comma-delimited list of characteristics of this node. Valid values: ppc, blade, vm (virtual machine), osi (OS image), mm, mn, rsa, switch.'
  end
  
  newproperty(:ondiscover) do
    desc '(chain.ondiscover) This attribute is currently not used by xCAT. The "nodediscover" operation is always done during node discovery.'
  end
  
  newproperty(:os) do
    desc '(nodetype.os) The operating system deployed on this node. Valid values: AIX, rhels*,rhelc*, rhas*,centos*,SL*, fedora*, sles* (where * is the version #). As a special case, if this is set to "boottarget", then it will use the initrd/kernel/parameters specified in the row in the boottarget table in which boottarget.bprofile equals nodetype.profile.'
  end
  
  newproperty(:osvolume) do
    desc <<-eos
    (storage.osvolume)
    Specification of what storage to place the node OS image onto. Examples include:
  
              localdisk (Install to first non-FC attached disk)
              usbdisk (Install to first USB mass storage device seen)
              wwn=0x50000393c813840c (Install to storage device with given WWN)
    eos
  end
  
  newproperty(:otherinterfaces) do
    desc '(hosts.otherinterfaces) Other IP addresses to add for this node. Format: -<ext>:<ip>,<intfhostname>:<ip>,...'
  end
  
  newproperty(:ou) do
    desc '(domain.ou) For an LDAP described machine account (i.e. Active Directory), the orginaztional unit to place the system. If not set, defaults to cn=Computers,dc=your,dc=domain'
  end
  
  newproperty(:parent) do
    desc '(ppc.parent) For LPARs: the CEC; for FSPs: the CEC; for CEC: the frame (if one exists); for BPA: the frame; for frame: the building block number (which consists 1 or more service nodes and compute/storage nodes that are serviced by them - optional).'
  end
  
  newproperty(:passwd_HMC) do
    desc 'passwd.HMC (ppcdirect.password) Password of the FSP/BPA(for ASMI) and CEC/Frame(for DFM). If not filled in, xCAT will look in the passwd table for key=fsp. If not in the passwd table, the default used is admin.'
  end
  
  newproperty(:passwd_admin) do
    desc 'passwd.admin (ppcdirect.password) Password of the FSP/BPA(for ASMI) and CEC/Frame(for DFM). If not filled in, xCAT will look in the passwd table for key=fsp. If not in the passwd table, the default used is admin.'
  end
  
  newproperty(:passwd_celogin) do
    desc 'passwd.celogin (ppcdirect.password) Password of the FSP/BPA(for ASMI) and CEC/Frame(for DFM). If not filled in, xCAT will look in the passwd table for key=fsp. If not in the passwd table, the default used is admin.'
  end
  
  newproperty(:passwd_general) do
    desc 'passwd.general (ppcdirect.password) Password of the FSP/BPA(for ASMI) and CEC/Frame(for DFM). If not filled in, xCAT will look in the passwd table for key=fsp. If not in the passwd table, the default used is admin.'
  end
  
  newproperty(:passwd_hscroot) do
    desc'passwd.hscroot (ppcdirect.password) Password of the FSP/BPA(for ASMI) and CEC/Frame(for DFM). If not filled in, xCAT will look in the passwd table for key=fsp. If not in the passwd table, the default used is admin.'
  end
  
  newproperty(:password) do
    desc <<-eos
    (ppchcp.password, mpa.password, websrv.password) 
    Password of the HMC or IVM. If not filled in, xCAT will look in the passwd table for key=hmc or key=ivm. If not in the passwd table, the default used is abc123 for HMCs and padmin for IVMs.
  
    or
    
    Password to use to access the management module. If not specified, the key=blade row in the passwd table is used as the default.
    
    or
    
    Password to use to access the web service.
    eos
  end
  
  newproperty(:postbootscripts) do
    desc '(postscripts.postbootscripts) Comma separated list of scripts that should be run on this node after diskfull installation or diskless boot. Each script can take zero or more parameters. For example: "script1 p1 p2,script2,...". On AIX these scripts are run during the processing of /etc/inittab. On Linux they are run at the init.d time. xCAT automatically adds the scripts in the xcatdefaults.postbootscripts attribute to run first in the list.'
  end
  
  newproperty(:postscripts) do
    desc '(postscripts.postscripts) Comma separated list of scripts that should be run on this node after diskfull installation or diskless boot. Each script can take zero or more parameters. For example: "script1 p1 p2,script2,...". xCAT automatically adds the postscripts from the xcatdefaults.postscripts attribute of the table to run first on the nodes after install or diskless boot. For installation of RedHat, CentOS, Fedora, the scripts will be run before the reboot. For installation of SLES, the scripts will be run after the reboot but before the init.d process. For diskless deployment, the scripts will be run at the init.d time, and xCAT will automatically add the list of scripts from the postbootscripts attribute to run after postscripts list. For installation of AIX, the scripts will run after the reboot and acts the same as the postbootscripts attribute. For AIX, use the postbootscripts attribute. Support will be added in the future for the postscripts attribute to run the scripts before the reboot in AIX.'
  end
  
  newproperty(:power) do
    desc '(nodehm.power) The method to use to control the power of the node. If not set, the mgt attribute will be used. Valid values: ipmi, blade, hmc, ivm, fsp, kvm, esx, rhevm. If "ipmi", xCAT will search for this node in the ipmi table for more info. If "blade", xCAT will search for this node in the mp table. If "hmc", "ivm", or "fsp", xCAT will search for this node in the ppc table.'
  end
  
  newproperty(:pprofile) do
    desc '(ppc.pprofile) The LPAR profile that will be used the next time the LPAR is powered on with rpower. For DFM, the pprofile attribute should be set to blank'
  end
  
  newproperty(:prescripts_begin) do
    desc <<-eos
    prescripts-begin (prescripts.begin)
    The scripts to be run at the beginning of the nodeset(Linux),

     nimnodeset(AIX) or mkdsklsnode(AIX) command.
     The format is:
       [action1:]s1,s2...[|action2:s3,s4,s5...]
     where:
      - action1 and action2 for Linux are the nodeset actions specified in the command.
        For AIX, action1 and action1 can be 'diskless' for mkdsklsnode command'
        and 'standalone for nimnodeset command.
      - s1 and s2 are the scripts to run for action1 in order.
      - s3, s4, and s5 are the scripts to run for actions2.
     If actions are omitted, the scripts apply to all actions.
     Examples:
       myscript1,myscript2  (all actions)
       diskless:myscript1,myscript2   (AIX)
       install:myscript1,myscript2|netboot:myscript3   (Linux)
     All the scripts should be copied to /install/prescripts directory.
     The following two environment variables will be passed to each script:
       NODES a coma separated list of node names that need to run the script for
       ACTION current nodeset action.
     If '#xCAT setting:MAX_INSTANCE=number' is specified in the script, the script
     will get invoked for each node in parallel, but no more than number of instances
     will be invoked at at a time. If it is not specified, the script will be invoked
     once for all the nodes.
     eos
   end
   
  newproperty(:prescripts_end) do
    desc <<-eos
    prescripts-end (prescripts.end)
    The scripts to be run at the end of the nodeset(Linux),

     nimnodeset(AIX),or mkdsklsnode(AIX) command.
     The format is the same as the 'begin' column.
    eos
  end
  
  newproperty(:primarynic) do
    desc '(noderes.primarynic) The network adapter on the node that will be used for xCAT management, the primarynic can be set to the network adapter name or the mac address or the keyword "mac" which means that the network interface specified by the mac address in the mac table will be used. Default is eth0.'
  end
  
  newproperty(:productkey) do
    desc '(prodkey.key) The product key relevant to the aforementioned node/group and product combination'
  end
  
  newproperty(:profile) do
    desc '(nodetype.profile) The string to use to locate a kickstart or autoyast template to use for OS deployment of this node. If the provmethod attribute is set to an osimage name, that takes precedence, and profile need not be defined. Otherwise, the os, profile, and arch are used to search for the files in /install/custom first, and then in /opt/xcat/share/xcat.'
  end
  
  newproperty(:provmethod) do
    desc '(nodetype.provmethod) The provisioning method for node deployment. The valid values are install, netboot, statelite or an os image name from the osimage table. If an image name is specified, the osimage definition stored in the osimage table and the linuximage table (for Linux) or nimimage table (for AIX) are used to locate the files for templates, pkglists, syncfiles, etc. On Linux, if install, netboot or statelite is specified, the os, profile, and arch are used to search for the files in /install/custom first, and then in /opt/xcat/share/xcat.'
  end
  
  newproperty(:rack) do
    desc '(nodepos.rack) The frame the node is in.'
  end
  
  newproperty(:room) do
    desc '(nodepos.room) The room where the node is located.'
  end
  
  newproperty(:routenames) do
    desc '(noderes.routenames) A comma separated list of route names that refer to rows in the routes table. These are the routes that should be defined on this node when it is deployed.'
  end
  
  newproperty(:serial) do
    desc '(vpd.serial) The serial number of the node.'
  end
  
  newproperty(:serialflow) do
    desc '(nodehm.serialflow) The flow control value of the serial port for this node. For SOL this is typically 'hard'.'
  end
  
  newproperty(:serialport) do
    desc '(nodehm.serialport) The serial port for this node, in the linux numbering style (0=COM1/ttyS0, 1=COM2/ttyS1). For SOL on IBM blades, this is typically 1. For rackmount IBM servers, this is typically 0.'
  end
  
  newproperty(:serialspeed) do
    desc '(nodehm.serialspeed) The speed of the serial port for this node. For SOL this is typically 19200.'
  end
  
  newproperty(:servicenode) do
    desc '(noderes.servicenode) A comma separated list of node names (as known by the management node) that provides most services for this node. The first service node on the list that is accessible will be used. The 2nd node on the list is generally considered to be the backup service node for this node when running commands like snmove.'
  end
  
  newproperty(:setupconserver) do
    desc '(servicenode.conserver) Do we set up Conserver on this service node? Valid values:yes or 1, no or 0. If yes, configures and starts conserver daemon. If no or 0, it does not change the current state of the service.'
    newvalues(:yes, :no, 0, 1)
  end
  
  newproperty(:setupdhcp) do
    desc '(servicenode.dhcpserver) Do we set up DHCP on this service node? Not supported on AIX. Valid values:yes or 1, no or 0. If yes, runs makedhcp -n. If no or 0, it does not change the current state of the service.'
    newvalues(:yes, :no, 0, 1)
  end
  
  newproperty(:setupftp) do
    desc 'Do we set up a ftp server on this service node? Not supported on AIX Valid values:yes or 1, no or 0. If yes, configure and start vsftpd. (You must manually install vsftpd on the service nodes before this.) If no or 0, it does not change the current state of the service. xCAT is not using ftp for compute nodes provisioning or any other xCAT features, so this attribute can be set to 0 if the ftp service will not be used for other purposes'
  end
  
  newproperty(:setupipforward) do
    desc '(servicenode.ipforward) Do we set up ip forwarding on this service node? Valid values:yes or 1, no or 0. If no or 0, it does not change the current state of the service.'
  end
  
  newproperty(:setupldap) do
    desc '(servicenode.ldapserver) Do we set up ldap caching proxy on this service node? Not supported on AIX. Valid values:yes or 1, no or 0. If no or 0, it does not change the current state of the service.'
  end
  
  newproperty(:setupnameserver) do
    desc '(servicenode.nameserver) Do we set up DNS on this service node? Valid values: 2, 1, no or 0. If 2, creates named.conf as dns slave, using the management node as dns master, and starts named. If 1, creates named.conf file with forwarding to the management node and starts named. If no or 0, it does not change the current state of the service.'
  end
  
  newproperty(:setupnfs) do
    desc '(servicenode.nfsserver) Do we set up file services (HTTP,FTP,or NFS) on this service node? For AIX will only setup NFS, not HTTP or FTP. Valid values:yes or 1, no or 0.If no or 0, it does not change the current state of the service.'
  end
  
  newproperty(:setupnim) do
    desc '(servicenode.nimserver) Not used. Do we set up a NIM server on this service node? Valid values:yes or 1, no or 0. If no or 0, it does not change the current state of the service.'
  end
  
  newproperty(:setupntp) do
    desc '(servicenode.ntpserver) Not used. Use setupntp postscript to setup a ntp server on this service node? Valid values:yes or 1, no or 0. If no or 0, it does not change the current state of the service.'
  end
  
  newproperty(:setupproxydhcp) do
    desc '(servicenode.proxydhcp) Do we set up proxydhcp service on this node? valid values: yes or 1, no or 0. If yes, the proxydhcp daemon will be enabled on this node.'
    newvalues(:yes, :no, 0, 1)
  end
  
  newproperty(:setuptftp) do
    desc '(servicenode.tftpserver) Do we set up TFTP on this service node? Not supported on AIX. Valid values:yes or 1, no or 0. If yes, configures and starts atftp. If no or 0, it does not change the current state of the service.'
  end
  
  newproperty(:sfp) do
    desc '(ppc.sfp) The Service Focal Point of this Frame. This is the name of the HMC that is responsible for collecting hardware service events for this frame and all of the CECs within this frame.'
  end
  
  newproperty(:side) do
    desc '(vpd.side) <BPA>-<port> or <FSP>-<port>. The side information for the BPA/FSP. The side attribute refers to which BPA/FSP, A or B, which is determined by the slot value returned from lsslp command. It also lists the physical port within each BPA/FSP which is determined by the IP address order from the lsslp response. This information is used internally when communicating with the BPAs/FSPs'
  end
  
  newproperty(:slot) do
    desc '(nodepos.slot) The slot number of the blade in the chassis. For PCM, a comma-separated list of slot numbers is stored'
  end
  
  newproperty(:slotid) do
    desc '(mp.id) The slot number of this blade in the BladeCenter chassis.'
  end
  
  newproperty(:slots) do
    desc <<-eos
    (mpa.slots) 
    The number of available slots in the chassis. For PCM, this attribute is used to store the number of slots in the following format: <slot rows>,<slot columns>,<slot orientation> Where:

     <slot rows>  = number of rows of slots in chassis
     <slot columns> = number of columns of slots in chassis
     <slot orientation> = set to 0 if slots are vertical, and set to 1 if slots of horizontal
    eos
  end
  
  newproperty(:storagcontroller) do
    desc <<-eos
    (storage.controller)
    The management address to attach/detach new volumes.

       In the scenario involving multiple controllers, this data must be
       passed as argument rather than by table value
     eos
   end
   
   newproperty(:storagetype) do
     desc '(storage.type) The plugin used to drive storage configuration (e.g. svc)'
   end
   
   newproperty(:supernode) do
     desc '(ppc.supernode) Indicates the connectivity of this CEC in the HFI network. A comma separated list of 2 ids. The first one is the supernode number the CEC is part of. The second one is the logical location number (0-3) of this CEC within the supernode.'
   end
   
   newproperty(:supportedarchs) do
     desc '(nodetype.supportedarchs) Comma delimited list of architectures this node can execute.'
   end
   
   newproperty(:supportproxydhcp) do
     desc '(noderes.proxydhcp) To specify whether the node supports proxydhcp protocol. Valid values: yes or 1, no or 0. Default value is yes.'
     newvalues(:yes, :no, 0, 1)
   end
   
   newproperty(:switch) do
     desc '(switch.switch) The switch hostname.'
   end
   
   newproperty(:switchinterface) do
     desc '(switch.interface) The interface name from the node perspective. For example, eth0. For the primary nic, it can be empty, the word "primary" or "primary:ethx" where ethx is the interface name.'
   end
   
   newproperty(:switchport) do
     desc '(switch.port) The port number in the switch that this node is connected to. On a simple 1U switch, an administrator can generally enter the number as printed next to the ports, and xCAT will understand switch representation differences. On stacked switches or switches with line cards, administrators should usually use the CLI representation (i.e. 2/0/1 or 5/8). One notable exception is stacked SMC 8848M switches, in which you must add 56 for the proceeding switch, then the port number. For example, port 3 on the second switch in an SMC8848M stack would be 59'
   end
   
   newproperty(:switchvlan) do
     desc '(switch.vlan) The ID for the tagged vlan that is created on this port using mkvlan and chvlan commands.'
   end
   
   newproperty(:termport) do
     desc '(nodehm.termport) The port number on the terminal server that this node is connected to.'
   end
   
   newproperty(:termserver) do
     desc '(nodehm.termserver) The hostname of the terminal server.'
   end
   
   newproperty(:tftpdir) do
     desc '(noderes.tftpdir) The directory that roots this nodes contents from a tftp and related perspective. Used for NAS offload by using different mountpoints.'
   end
   
   newproperty(:tftpserver) do
     desc '(noderes.tftpserver) The TFTP server for this node (as known by this node). If not set, it defaults to networks.tftpserver.'
   end
   
   newproperty(:unit) do
     desc '(nodepos.u) The vertical position of the node in the frame'
   end
   
   newproperty(:urlpath) do
     desc '(mpa.urlpath) URL path for the Chassis web interface. The full URL is built as follows: <hostname>/<urlpath>'
   end
   
   newproperty(:userid) do
     desc '(zvm.userid) The z/VM userID of this node.'
   end
   
   newproperty(:username) do
     desc <<-eos
     (ppchcp.username, mpa.username, websrv.username)
     Userid of the HMC or IVM. If not filled in, xCAT will look in the passwd table for key=hmc or key=ivm. If not in the passwd table, the default used is hscroot for HMCs and padmin for IVMs.

      or
      
      Userid to use to access the management module.
      
      or
      
      Userid to use to access the web service.
     eos
   end
   
   newproperty(:vmbootorder) do
     desc '(vm.bootorder) Boot sequence (i.e. net,hd)'
   end
   
   newproperty(:vmcfgstore) do
     desc '(vm.cfgstore) Optional location for persistant storage separate of emulated hard drives for virtualization solutions that require persistant store to place configuration data'
   end
   
   newproperty(:vmcluster) do
     desc '(vm.cluster) Specify to the underlying virtualization infrastructure a cluster membership for the hypervisor.'
   end
   
   newproperty(:vmcpus) do
     desc '(vm.cpus) Number of CPUs the node should see.'
   end
   
   newproperty(:vmhost) do
     desc '(vm.host) The system that currently hosts the VM'
   end
   
   newproperty(:vmmanager) do
     desc '(vm.mgr) The function manager for the virtual machine'
   end
   
   newproperty(:vmmaster) do
     desc '(vm.master) The name of a master image, if any, this virtual machine is linked to. This is generally set by clonevm and indicates the deletion of a master that would invalidate the storage of this virtual machine'
   end
   
   newproperty(:vmmemory) do
     desc '(vm.memory) Megabytes of memory the VM currently should be set to.'
   end
   
   newproperty(:vmnicnicmodel) do
     desc '(vm.nicmodel) Model of NICs that will be provided to VMs (i.e. e1000, rtl8139, virtio, etc)'
   end
   
   newproperty(:vmnics) do
     desc '(vm.nics) Network configuration parameters. Of the general form [physnet:]interface,.. Generally, interface describes the vlan entity (default for native, tagged for tagged, vl[number] for a specific vlan. physnet is a virtual switch name or port description that is used for some virtualization technologies to construct virtual switches. hypervisor.netmap can map names to hypervisor specific layouts, or the descriptions described there may be used directly here where possible.'
   end
   
   newproperty(:vmothersetting) do
     desc '(vm.othersettings) This allows specifying a semicolon delimited list of key->value pairs to include in a vmx file of VMware. For partitioning on normal power machines, this option is used to specify the hugepage and/or bsr information, the value is like:\'hugepage:1,bsr=2\'.'
   end
   
   newproperty(:vmphyslots) do
     desc '(vm.physlots) Specify the physical slots drc index that will assigned to the partition, the delimiter is \',\', and the drc index must started with \'0x\'. For more details, please reference to manpage of \'lsvm\'.'
   end
   
   newproperty(:vmstorage) do
     desc '(vm.storage) A list of storage files or devices to be used. i.e. dir:///cluster/vm/<nodename> or nfs://<server>/path/to/folder/'
   end
     
   newproperty(:vmstoragecache) do
     desc '(vm.storagecache) Select caching scheme to employ. E.g. KVM understands \'none\', \'writethrough\' and \'writeback\''
   end
   
   newproperty(:vmstorageformat) do
     desc '(vm.storageformat) Select disk format to use by default (e.g. raw versus qcow2)'
   end
   
   newproperty(:vmstoragemodel) do
     desc '(vm.storagemodel) Model of storage devices to provide to guest'
   end
   
   newproperty(:vmtextconsole) do
     desc '(vm.textconsole) Tracks the Psuedo-TTY that maps to the serial port or console of a VM'
   end
   
   newproperty(:vmvirtflags) do
     desc <<-eos
     (vm.virtflags)
     General flags used by the virtualization method. For example, in Xen it could, among other things, specify paravirtualized setup, or direct kernel boot. For a hypervisor/dom0 entry, it is the virtualization method (i.e. "xen"). For KVM, the following flag=value pairs are recognized:

            imageformat=[raw|fullraw|qcow2]
                raw is a generic sparse file that allocates storage on demand
                fullraw is a generic, non-sparse file that preallocates all space
                qcow2 is a sparse, copy-on-write capable format implemented at the virtualization layer rather than the filesystem level
            clonemethod=[qemu-img|reflink]
                qemu-img allows use of qcow2 to generate virtualization layer copy-on-write
                reflink uses a generic filesystem facility to clone the files on your behalf, but requires filesystem support such as btrfs
            placement_affinity=[migratable|user_migratable|pinned]
     eos
   end
   
   newproperty(:vmvncport) do
     desc '(vm.vncport) Tracks the current VNC display port (currently not meant to be set'
   end
   
   newproperty(:webport) do
     desc '(websrv.port) The port of the web service.'
   end
   
   newproperty(:wherevals) do
     desc '(nodegroup.wherevals) A list of "attr*val" pairs that can be used to determine the members of a dynamic group, the delimiter is "::" and the operator * can be ==, =~, != or !~.'
   end
   
   newproperty(:xcatmaster) do
     desc '(noderes.xcatmaster) The hostname of the xCAT service node (as known by this node). This acts as the default value for nfsserver and tftpserver, if they are not set. If xcatmaster is not set, the node will use whoever responds to its boot request as its master. For the directed bootp case for POWER, it will use the management node if xcatmaster is not set.'
   end
end
