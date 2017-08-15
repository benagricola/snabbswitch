local bit_lshift = require('bit').lshift

ZEBRA_INTERFACE_ADD = 1
ZEBRA_INTERFACE_DELETE = 2
ZEBRA_INTERFACE_ADDRESS_ADD = 3
ZEBRA_INTERFACE_ADDRESS_DELETE = 4
ZEBRA_INTERFACE_UP = 5
ZEBRA_INTERFACE_DOWN = 6
ZEBRA_IPV4_ROUTE_ADD = 7
ZEBRA_IPV4_ROUTE_DELETE = 8
ZEBRA_IPV6_ROUTE_ADD = 9
ZEBRA_IPV6_ROUTE_DELETE = 10
ZEBRA_REDISTRIBUTE_ADD = 11
ZEBRA_REDISTRIBUTE_DELETE = 12
ZEBRA_REDISTRIBUTE_DEFAULT_ADD = 13
ZEBRA_REDISTRIBUTE_DEFAULT_DELETE = 14
ZEBRA_IPV4_NEXTHOP_LOOKUP = 15
ZEBRA_IPV6_NEXTHOP_LOOKUP = 16
ZEBRA_IPV4_IMPORT_LOOKUP = 17
ZEBRA_IPV6_IMPORT_LOOKUP = 18
ZEBRA_INTERFACE_RENAME = 19
ZEBRA_ROUTER_ID_ADD = 20
ZEBRA_ROUTER_ID_DELETE = 21
ZEBRA_ROUTER_ID_UPDATE = 22
ZEBRA_HELLO = 23
ZEBRA_IPV4_NEXTHOP_LOOKUP_MRIB = 24
ZEBRA_VRF_UNREGISTER = 25
ZEBRA_INTERFACE_LINK_PARAMS = 26
ZEBRA_NEXTHOP_REGISTER = 27
ZEBRA_NEXTHOP_UNREGISTER = 28
ZEBRA_NEXTHOP_UPDATE = 29
ZEBRA_MESSAGE_MAX = 30

-- Zebra route types
ZEBRA_ROUTE_SYSTEM = 0
ZEBRA_ROUTE_KERNEL = 1
ZEBRA_ROUTE_CONNECT = 2
ZEBRA_ROUTE_STATIC = 3
ZEBRA_ROUTE_RIP = 4
ZEBRA_ROUTE_RIPNG = 5
ZEBRA_ROUTE_OSPF = 6
ZEBRA_ROUTE_OSPF6 = 7
ZEBRA_ROUTE_ISIS = 8
ZEBRA_ROUTE_BGP = 9
ZEBRA_ROUTE_PIM = 10
ZEBRA_ROUTE_HSLS = 11
ZEBRA_ROUTE_OLSR = 12
ZEBRA_ROUTE_BABEL = 13
ZEBRA_ROUTE_MAX = 14

-- Zebra message flags
ZEBRA_FLAG_INTERNAL = 0x01
ZEBRA_FLAG_SELFROUTE = 0x02
ZEBRA_FLAG_BLACKHOLE = 0x04
ZEBRA_FLAG_IBGP = 0x08
ZEBRA_FLAG_SELECTED = 0x10
ZEBRA_FLAG_FIB_OVERRIDE = 0x20
ZEBRA_FLAG_STATIC = 0x40
ZEBRA_FLAG_REJECT = 0x80

-- Zebra nexthop flags
ZEBRA_NEXTHOP_IFINDEX = 1
ZEBRA_NEXTHOP_IFNAME = 2
ZEBRA_NEXTHOP_IPV4 = 3
ZEBRA_NEXTHOP_IPV4_IFINDEX = 4
ZEBRA_NEXTHOP_IPV4_IFNAME = 5
ZEBRA_NEXTHOP_IPV6 = 6
ZEBRA_NEXTHOP_IPV6_IFINDEX = 7
ZEBRA_NEXTHOP_IPV6_IFNAME = 8
ZEBRA_NEXTHOP_BLACKHOLE = 9


-- Constants in quagga/lib/zclient.h

-- Zebra API message flags
ZAPI_MESSAGE_NEXTHOP = 0x01
ZAPI_MESSAGE_IFINDEX = 0x02
ZAPI_MESSAGE_DISTANCE = 0x04
ZAPI_MESSAGE_METRIC = 0x08
ZAPI_MESSAGE_MTU = 0x10
ZAPI_MESSAGE_TAG = 0x20

INTERFACE_NAMSIZE = 20
INTERFACE_HWADDR_MAX = 20

ZEBRA_INTERFACE_ACTIVE = bit_lshift(1, 0)
ZEBRA_INTERFACE_SUB = bit_lshift(1, 1)
ZEBRA_INTERFACE_LINKDETECTION = bit_lshift(1, 2)

-- Zebra link layer types
ZEBRA_LLT_UNKNOWN = 0
ZEBRA_LLT_ETHER = 1
ZEBRA_LLT_EETHER = 2
ZEBRA_LLT_AX25 = 3
ZEBRA_LLT_PRONET = 4
ZEBRA_LLT_IEEE802 = 5
ZEBRA_LLT_ARCNET = 6
ZEBRA_LLT_APPLETLK = 7
ZEBRA_LLT_DLCI = 8
ZEBRA_LLT_ATM = 9
ZEBRA_LLT_METRICOM = 10
ZEBRA_LLT_IEEE1394 = 11
ZEBRA_LLT_EUI64 = 12
ZEBRA_LLT_INFINIBAND = 13
ZEBRA_LLT_SLIP = 14
ZEBRA_LLT_CSLIP = 15
ZEBRA_LLT_SLIP6 = 16
ZEBRA_LLT_CSLIP6 = 17
ZEBRA_LLT_RSRVD = 18
ZEBRA_LLT_ADAPT = 19
ZEBRA_LLT_ROSE = 20
ZEBRA_LLT_X25 = 21
ZEBRA_LLT_PPP = 22
ZEBRA_LLT_CHDLC = 23
ZEBRA_LLT_LAPB = 24
ZEBRA_LLT_RAWHDLC = 25
ZEBRA_LLT_IPIP = 26
ZEBRA_LLT_IPIP6 = 27
ZEBRA_LLT_FRAD = 28
ZEBRA_LLT_SKIP = 29
ZEBRA_LLT_LOOPBACK = 30
ZEBRA_LLT_LOCALTLK = 31
ZEBRA_LLT_FDDI = 32
ZEBRA_LLT_SIT = 33
ZEBRA_LLT_IPDDP = 34
ZEBRA_LLT_IPGRE = 35
ZEBRA_LLT_IP6GRE = 36
ZEBRA_LLT_PIMREG = 37
ZEBRA_LLT_HIPPI = 38
ZEBRA_LLT_ECONET = 39
ZEBRA_LLT_IRDA = 40
ZEBRA_LLT_FCPP = 41
ZEBRA_LLT_FCAL = 42
ZEBRA_LLT_FCPL = 43
ZEBRA_LLT_FCFABRIC = 44
ZEBRA_LLT_IEEE802_TR = 45
ZEBRA_LLT_IEEE80211 = 46
ZEBRA_LLT_IEEE80211_RADIOTAP = 47
ZEBRA_LLT_IEEE802154 = 48
ZEBRA_LLT_IEEE802154_PHY = 49

-- "non-official" architectural constants
MAX_CLASS_TYPE = 8
