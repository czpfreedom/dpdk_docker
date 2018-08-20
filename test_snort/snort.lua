---------------------------------------------------------------------------
-- Snort++ prototype configuration
---------------------------------------------------------------------------

---------------------------------------------------------------------------
-- setup environment
---------------------------------------------------------------------------
-- given:
-- export DIR=/install/path
-- configure --prefix=$DIR
-- make install
--
-- then:
-- export LUA_PATH=$DIR/include/snort/lua/?.lua\;\;
-- export SNORT_LUA_PATH=$DIR/conf/
---------------------------------------------------------------------------



require("snort_config")

dir = os.getenv('SNORT_LUA_PATH')

if ( not dir ) then
    dir = '.'
end

dofile(dir .. '/snort_defaults.lua')


HOME_NET = 'any'

EXTERNAL_NET = 'any'

DNS_SERVERS = HOME_NET

SMTP_SERVERS = HOME_NET

HTTP_SERVERS = HOME_NET

SQL_SERVERS = HOME_NET

TELNET_SERVERS = HOME_NET

SSH_SERVERS = HOME_NET

FTP_SERVERS = HOME_NET

SIP_SERVERS = HOME_NET

HTTP_PORTS = [[ 80 81 311 383 591 593 901 1220 1414 1741 1830 2301 2381 2809
    3037 3128 3702 4343 4848 5250 6988 7000 7001 7144 7145 7510 7777 7779
    8000 8008 8014 8028 8080 8085 8088 8090 8118 8123 8180 8181 8243 8280
    8300 8800 8888 8899 9000 9060 9080 9090 9091 9443 9999 11371 34443 34444
    41080 50002 55555 ]]

SHELLCODE_PORTS = '!80'

ORACLE_PORTS = '1024:'

SSH_PORTS = '22'

FTP_PORTS = '21 2100 3535'

SIP_PORTS = '5060 5061 5600'

FILE_DATA_PORTS = HTTP_PORTS .. ' 110 143'

GTP_PORTS = '2123 2152 3386'

AIM_SERVERS = [[ 64.12.24.0/23 64.12.28.0/23 64.12.161.0/24 64.12.163.0/24
    64.12.200.0/24 205.188.3.0/24 205.188.5.0/24 205.188.7.0/24
    205.188.9.0/24 205.188.153.0/24 205.188.179.0/24 205.188.248.0/24 ]]

RULE_PATH = './community-rules'

SO_RULE_PATH = '../so_rules'

PREPROC_RULE_PATH = '../preproc_rules'

WHITE_LIST_PATH = '../rules'

BLACK_LIST_PATH = '../rules'

include 'classification.config.lua'

include 'reference.config.lua'

local_rules =
[[
include community.rules.rules
include temp.rules.rules
]]

deleted_snort_config_options =
{
    --option deleted: 'config disable_decode_alerts[:.*]'
    --option deleted: 'config disable_ipopt_alerts[:.*]'
    --option deleted: 'config disable_tcpopt_alerts[:.*]'
    --option deleted: 'config disable_tcpopt_experimental_alerts[:.*]'
    --option deleted: 'config disable_tcpopt_obsolete_alerts[:.*]'
    --option deleted: 'config disable_tcpopt_ttcp_alerts[:.*]'
}

detection =
{
    pcre_match_limit = 3500,
    pcre_match_limit_recursion = 1500,
}

search_engine =
{
    split_any_any = true,
    search_method = 'ac_full',
    search_optimize = true,
    max_pattern_len = 20,
    --This table was previously 'config detection: ...
    --option change: 'ac-split' --> 'ac_full'
    --option change: 'ac-split' --> 'split_any_any'
    --option change: 'max-pattern-len' --> 'max_pattern_len'
    --option change: 'search-method' --> 'search_method'
    --option change: 'search-optimize' --> 'search_optimize'
}

event_queue =
{
    max_queue = 8,
    log = 5,
    order_events = 'content_length',
}

stream_ip =
{
    max_frags = 65536,
    policy = 'windows',
    max_overlaps = 10,
    min_frag_length = 100,
    session_timeout = 180,
    --option change: 'min_fragment_length' --> 'min_frag_length'
    --option change: 'overlap_limit' --> 'max_overlaps'
    --option change: 'timeout' --> 'session_timeout'
    --option deleted: 'detect_anomalies'
}

stream =
{
    tcp_cache =
    {
        max_sessions = 262144,
        --option change: 'max_tcp' --> 'max_sessions'
    },
    udp_cache =
    {
        max_sessions = 131072,
        --option change: 'max_udp' --> 'max_sessions'
    },
    --option deleted: 'track_icmp'
    --option deleted: 'track_tcp'
    --option deleted: 'track_udp'
}

active =
{
    max_responses = 2,
    min_interval = 5,
    --option change: 'max_active_responses' --> 'max_responses'
    --option change: 'min_response_seconds' --> 'min_interval'
}

reject =
{
    reset = 'both',
}

stream_tcp =
{
    policy = 'windows',
    require_3whs = 180,
    overlap_limit = 10,
    session_timeout = 180,
    small_segments =
    {
        count = 3,
        maximum_size = 150,
    },
    --option change: 'both ports' --> 'binder.when.ports; binder.when.role =
    --    any'
    --option change: 'client ports' --> 'binder.when.ports; binder.when.role =
    --    client'
    --option change: 'timeout' --> 'session_timeout'
    --option deleted: 'detect_anomalies'
    --option deleted: 'log_asymmetric_traffic'
}

stream_udp =
{
    session_timeout = 180,
    --option change: 'timeout' --> 'session_timeout'
}

http_inspect =
{
    iis_unicode_map_file = 'unicode.map',
    iis_unicode_code_page = 1252,
    --http_methods = 'GET POST PUT SEARCH MKCOL COPY MOVE LOCK UNLOCK NOTIFY POLL BCOPY BDELETE BMOVE LINK UNLINK OPTIONS HEAD DELETE TRACE TRACK CONNECT SOURCE SUBSCRIBE UNSUBSCRIBE PROPFIND PROPPATCH BPROPFIND BPROPPATCH RPC_CONNECT PROXY_SUCCESS BITS_POST CCM_POST SMS_POST RPC_IN_DATA RPC_OUT_DATA RPC_ECHO_DATA',
    response_depth = -1,
    request_depth = -1,
    oversize_dir_length = 500,
    unzip = true,
    normalize_utf = true,
    normalize_javascript = true,
    utf8_bare_byte = false,
    iis_double_decode = false,
    backslash_to_slash = false,
    iis_unicode = false,
    utf8 = false,
    percent_u = true,
    simplify_path = false,
    bad_characters = '0x0 0x1 0x2 0x3 0x4 0x5 0x6 0x7',
    --option change: 'bare_byte' --> 'utf8_bare_byte'
    --option change: 'client_flow_depth' --> 'request_depth'
    --option change: 'directory' --> 'simplify_path'
    --option change: 'double_decode' --> 'iis_double_decode'
    --option change: 'http_inspect_server' --> 'http_inspect'
    --option change: 'iis_backslash' --> 'backslash_to_slash'
    --option change: 'inspect_gzip' --> 'unzip'
    --option change: 'multi_slash' --> 'simplify_path'
    --option change: 'non_rfc_char' --> 'bad_characters'
    --option change: 'ports' --> 'bindings'
    --option change: 'server_flow_depth' --> 'response_depth'
    --option change: 'u_encode' --> 'percent_u'
    --option change: 'utf_8' --> 'utf8'
    --option deleted: 'apache_whitespace'
    --option deleted: 'ascii'
    --option deleted: 'chunk_length'
    --option deleted: 'compress_depth'
    --option deleted: 'decompress_depth'
    --option deleted: 'enable_cookie'
    --option deleted: 'extended_response_inspection'
    --option deleted: 'iis_delimiter'
    --option deleted: 'max_header_length'
    --option deleted: 'max_headers'
    --option deleted: 'max_spaces'
    --option deleted: 'post_depth'
    --option deleted: 'small_chunk_length'
    --option deleted: 'unlimited_decompress'
    --option deleted: 'webroot'
}

rpc_decode =
{
    --option deleted: 'no_alert_incomplete'
    --option deleted: 'no_alert_large_fragments'
    --option deleted: 'no_alert_multiple_requests'
}

bo =
{
}

unified2 =
{
    limit = 128,
    --option change: 'output unified2' --> 'unified2'
    --option deleted: 'filename'
    --option deleted: 'mpls_event_types'
    --option deleted: 'vlan_event_types'
}

network =
{
    checksum_eval = 'all',
    --option change: 'checksum_mode' --> 'checksum_eval'
}

normalizer =
{
    icmp4 = true,
    ip6 = true,
    icmp6 = true,
    ip4 =
    {
    },
    tcp =
    {
        ips = true,
        ecn = 'stream',
    },
    --option change: 'preprocessor normalize_icmp4' --> 'icmp4 = <bool>'
    --option change: 'preprocessor normalize_icmp6' --> 'icmp6 = <bool>'
    --option change: 'preprocessor normalize_ip6' --> 'ip6 = <bool>'
}

binder =
{
    { when = { service = 'cvs', proto = 'tcp', }, use = { type = 'stream_tcp', }, },
    { when = { service = 'dcerpc', proto = 'tcp', }, use = { type = 'stream_tcp', }, },
    { when = { service = 'dns', proto = 'tcp', }, use = { type = 'stream_tcp', }, },
    { when = { service = 'ftp', proto = 'tcp', }, use = { type = 'stream_tcp', }, },
    { when = { service = 'http', proto = 'tcp', }, use = { type = 'stream_tcp', }, },
    { when = { service = 'imap', proto = 'tcp', }, use = { type = 'stream_tcp', }, },
    { when = { service = 'login', proto = 'tcp', }, use = { type = 'stream_tcp', }, },
    { when = { service = 'mssql', proto = 'tcp', }, use = { type = 'stream_tcp', }, },
    { when = { service = 'mysql', proto = 'tcp', }, use = { type = 'stream_tcp', }, },
    { when = { service = 'nameserver', proto = 'tcp', }, use = { type = 'stream_tcp', }, },
    { when = { service = 'netbios-ssn', proto = 'tcp', }, use = { type = 'stream_tcp', }, },
    { when = { service = 'oracle', proto = 'tcp', }, use = { type = 'stream_tcp', }, },
    { when = { service = 'pop3', proto = 'tcp', }, use = { type = 'stream_tcp', }, },
    { when = { service = 'shell', proto = 'tcp', }, use = { type = 'stream_tcp', }, },
    { when = { service = 'smtp', proto = 'tcp', }, use = { type = 'stream_tcp', }, },
    { when = { service = 'sunrpc', proto = 'tcp', }, use = { type = 'stream_tcp', }, },
    { when = { service = 'telnet', proto = 'tcp', }, use = { type = 'stream_tcp', }, },
    { when = { proto = 'tcp', role = 'client', ports = '21 22 23 25 42 53 79 109 110 111 113 119 135 136 137 139 143 161 445 513 514 587 593 691 1433 1521 1741 2100 3306 6070 6665 6666 6667 6668 6669 7000 8181 32770 32771 32772 32773 32774 32775 32776 32777 32778 32779', }, use = { type = 'stream_tcp', }, },
    { when = { proto = 'tcp', ports = '111 32770 32771 32772 32773 32774 32775 32776 32777 32778 32779', }, use = { type = 'rpc_decode', }, },
    { when = { proto = 'tcp', ports = '80 81 311 383 591 593 901 1220 1414 1741 1830 2301 2381 2809 3037 3128 3702 4343 4848 5250 6988 7000 7001 7144 7145 7510 7777 7779 8000 8008 8014 8028 8080 8085 8088 8090 8118 8123 8180 8181 8243 8280 8300 8800 8888 8899 9000 9060 9080 9090 9091 9443 9999 11371 34443 34444 41080 50002 55555', }, use = { type = 'http_inspect', }, },
    { when = { proto = 'tcp', ports = '80 81 311 383 443 465 563 591 593 636 901 989 992 993 994 995 1220 1414 1830 2301 2381 2809 3037 3128 3702 4343 4848 5250 6988 7907 7000 7001 7144 7145 7510 7802 7777 7779 7801 7900 7901 7902 7903 7904 7905 7906 7908 7909 7910 7911 7912 7913 7914 7915 7916 7917 7918 7919 7920 8000 8008 8014 8028 8080 8085 8088 8090 8118 8123 8180 8243 8280 8300 8800 8888 8899 9000 9060 9080 9090 9091 9443 9999 11371 34443 34444 41080 50002 55555', }, use = { type = 'stream_tcp', }, },
}

ips =
{
    rules = local_rules,
}

--[[    COMMENTS:
 These lines were commented in the configuration file:


    --------------------------------------------------
    VRT Rule Packages Snort.conf


    For more information visit us at:
    http://www.snort.org Snort Website
    http://vrt-blog.snort.org/ Sourcefire VRT Blog


    Mailing list Contact: snort-sigs@lists.sourceforge.net
    False Positive reports: fp@sourcefire.com
    Snort bugs: bugs@snort.org


    Compatible with Snort Versions:
    VERSIONS : 2.9.11.1


    Snort build options:
    OPTIONS : --enable-gre --enable-mpls --enable-targetbased --enable-ppm
        --enable-perfprofiling --enable-zlib --enable-active-response
        --enable-normalizer --enable-reload --enable-react --enable-flexresp3


    Additional information:
    This configuration file enables active response, to run snort in
    test mode -T you are required to supply an interface -i <interface>
    or test mode will fail to fully validate the configuration and
    exit with a FATAL error
    --------------------------------------------------
    ##################################################
    This file contains a sample snort configuration.
    You should take the following steps to create your own custom
        configuration:


    1) Set the network variables.
    2) Configure the decoder
    3) Configure the base detection engine
    4) Configure dynamic loaded libraries
    5) Configure preprocessors
    6) Configure output plugins
    7) Customize your rule set
    8) Customize preprocessor and decoder rule set
    9) Customize shared object rule set
    ##################################################
    ##################################################
    Step #1: Set the network variables. For more information, see
        README.variables
    ##################################################
    Setup the network addresses you are protecting
    Set up the external network addresses. Leave as "any" in most situations
    List of DNS servers on your network
    List of SMTP servers on your network
    List of web servers on your network
    List of sql servers on your network
    List of telnet servers on your network
    List of ssh servers on your network
    List of ftp servers on your network
    List of sip servers on your network
    List of ports you run web servers on
    List of ports you want to look for SHELLCODE on.
    List of ports you might see oracle attacks on
    List of ports you want to look for SSH connections on:
    List of ports you run ftp servers on
    List of ports you run SIP servers on
    List of file data ports for file inspection
    List of GTP ports for GTP preprocessor
    other variables, these should not be modified
    Path to your rules files (this can be a relative path)
    Note for Windows users: You are advised to make this an absolute path,
    such as: c:\snort\rules
    If you are using reputation preprocessor set these
    Currently there is a bug with relative paths, they are relative to where
        snort is
    not relative to snort.conf like the above variables
    This is completely inconsistent with how other vars work, BUG 89986
    Set the absolute path appropriately
    ##################################################
    Step #2: Configure the decoder. For more information, see README.decode
    ##################################################
    Stop generic decode events:
    Stop Alerts on experimental TCP options
    Stop Alerts on obsolete TCP options
    Stop Alerts on T/TCP alerts
    Stop Alerts on all other TCPOption type events:
    Stop Alerts on invalid ip options
    Alert if value in length field (IP, TCP, UDP) is greater th elength of the
        packet
    config enable_decode_oversized_alerts
    Same as above, but drop packet if in Inline mode (requires
        enable_decode_oversized_alerts)
    config enable_decode_oversized_drops
    Configure IP / TCP checksum mode
    Configure maximum number of flowbit references. For more information, see
        README.flowbits
    config flowbits_size: 64
    Configure ports to ignore
    config ignore_ports: tcp 21 6667:6671 1356
    config ignore_ports: udp 1:17 53
    Configure active response for non inline operation. For more information,
        see REAMDE.active
    config response: eth0 attempts 2
    Configure DAQ related options for inline operation. For more information,
        see README.daq


    config daq: <type>
    config daq_dir: <dir>
    config daq_mode: <mode>
    config daq_var: <var>


    <type> ::= pcap | afpacket | dump | nfq | ipq | ipfw
    <mode> ::= read-file | passive | inline
    <var> ::= arbitrary <name>=<value passed to DAQ
    <dir> ::= path as to where to look for DAQ module so's
    Configure specific UID and GID to run snort as after dropping privs. For
        more information see snort -h command line options


    config set_gid:
    config set_uid:
    Configure default snaplen. Snort defaults to MTU of in use interface. For
        more information see README


    config snaplen:


    Configure default bpf_file to use for filtering what traffic reaches snort.
        For more information see snort -h command line options (-F)


    config bpf_file:


    Configure default log directory for snort to log to. For more information
        see snort -h command line options (-l)


    config logdir:
    ##################################################
    Step #3: Configure the base detection engine. For more information, see
        README.decode
    ##################################################
    Configure PCRE match limitations
    Configure the detection engine See the Snort Manual, Configuring Snort -
        Includes - Config
    Configure the event queue. For more information, see README.event_queue
    ##################################################
    # Configure GTP if it is to be used.
    # For more information, see README.GTP
    ###################################################
    config enable_gtp
    ##################################################
    Per packet and rule latency enforcement
    For more information see README.ppm
    ##################################################
    Per Packet latency configuration
    config ppm: max-pkt-time 250, \
    fastpath-expensive-packets, \
    pkt-log
    Per Rule latency configuration
    config ppm: max-rule-time 200, \
    threshold 3, \
    suspend-expensive-rules, \
    suspend-timeout 20, \
    rule-log alert
    ##################################################
    Configure Perf Profiling for debugging
    For more information see README.PerfProfiling
    ##################################################
    config profile_rules: print all, sort avg_ticks
    config profile_preprocs: print all, sort avg_ticks
    ##################################################
    Configure protocol aware flushing
    For more information see README.stream5
    ##################################################
    stream_tcp.max_pdu = 16000
    ##################################################
    Step #4: Configure dynamic loaded libraries.
    For more information, see Snort Manual, Configuring Snort - Dynamic Modules
    ##################################################
    path to dynamic preprocessor libraries
    dynamicpreprocessor directory /usr/local/lib/snort_dynamicpreprocessor/
    path to base preprocessor engine
    dynamicengine /usr/local/lib/snort_dynamicengine/libsf_engine.so
    path to dynamic rules libraries
    ##################################################
    Step #5: Configure preprocessors
    For more information, see the Snort Manual, Configuring Snort -
        Preprocessors
    ##################################################
    GTP Control Channle Preprocessor. For more information, see README.GTP
    preprocessor gtp: ports { 2123 3386 2152 }
    Inline packet normalization. For more information, see README.normalize
    Does nothing in IDS mode
    Target-based IP defragmentation. For more inforation, see README.frag3
    Target-Based stateful inspection/stream reassembly. For more inforation,
        see README.stream5
    performance statistics. For more information, see the Snort Manual,
        Configuring Snort - Preprocessors - Performance Monitor
    preprocessor perfmonitor: time 300 file /var/snort/snort.stats pktcnt 10000
    HTTP normalization and anomaly detection. For more information, see
        README.http_inspect
    ONC-RPC normalization and anomaly detection. For more information, see the
        Snort Manual, Configuring Snort - Preprocessors - RPC Decode
    Back Orifice detection.
    FTP / Telnet normalization and anomaly detection. For more information, see
        README.ftptelnet
    preprocessor ftp_telnet: global inspection_type stateful encrypted_traffic
        no check_encrypted
    preprocessor ftp_telnet_protocol: telnet \
    ayt_attack_thresh 20 \
    normalize ports { 23 } \
    detect_anomalies
    preprocessor ftp_telnet_protocol: ftp server default \
    def_max_param_len 100 \
    ports { 21 2100 3535 } \
    telnet_cmds yes \
    ignore_telnet_erase_cmds yes \
    ftp_cmds { ABOR ACCT ADAT ALLO APPE AUTH CCC CDUP } \
    ftp_cmds { CEL CLNT CMD CONF CWD DELE ENC EPRT } \
    ftp_cmds { EPSV ESTA ESTP FEAT HELP LANG LIST LPRT } \
    ftp_cmds { LPSV MACB MAIL MDTM MIC MKD MLSD MLST } \
    ftp_cmds { MODE NLST NOOP OPTS PASS PASV PBSZ PORT } \
    ftp_cmds { PROT PWD QUIT REIN REST RETR RMD RNFR } \
    ftp_cmds { RNTO SDUP SITE SIZE SMNT STAT STOR STOU } \
    ftp_cmds { STRU SYST TEST TYPE USER XCUP XCRC XCWD } \
    ftp_cmds { XMAS XMD5 XMKD XPWD XRCP XRMD XRSQ XSEM } \
    ftp_cmds { XSEN XSHA1 XSHA256 } \
    alt_max_param_len 0 { ABOR CCC CDUP ESTA FEAT LPSV NOOP PASV PWD QUIT REIN
        STOU SYST XCUP XPWD } \
    alt_max_param_len 200 { ALLO APPE CMD HELP NLST RETR RNFR STOR STOU XMKD }
        \
    alt_max_param_len 256 { CWD RNTO } \
    alt_max_param_len 400 { PORT } \
    alt_max_param_len 512 { SIZE } \
    chk_str_fmt { ACCT ADAT ALLO APPE AUTH CEL CLNT CMD } \
    chk_str_fmt { CONF CWD DELE ENC EPRT EPSV ESTP HELP } \
    chk_str_fmt { LANG LIST LPRT MACB MAIL MDTM MIC MKD } \
    chk_str_fmt { MLSD MLST MODE NLST OPTS PASS PBSZ PORT } \
    chk_str_fmt { PROT REST RETR RMD RNFR RNTO SDUP SITE } \
    chk_str_fmt { SIZE SMNT STAT STOR STRU TEST TYPE USER } \
    chk_str_fmt { XCRC XCWD XMAS XMD5 XMKD XRCP XRMD XRSQ } \
    chk_str_fmt { XSEM XSEN XSHA1 XSHA256 } \
    cmd_validity ALLO < int [ char R int ] > \
    cmd_validity EPSV < [ { char 12 | char A char L char L } ] > \
    cmd_validity MACB < string > \
    cmd_validity MDTM < [ date nnnnnnnnnnnnnn[.n[n[n] ] ] ] string > \
    cmd_validity MODE < char ASBCZ > \
    cmd_validity PORT < host_port > \
    cmd_validity PROT < char CSEP > \
    cmd_validity STRU < char FRPO [ string ] > \
    cmd_validity TYPE < { char AE [ char NTC ] | char I | char L [ number ] } >
    preprocessor ftp_telnet_protocol: ftp client default \
    max_resp_len 256 \
    bounce yes \
    ignore_telnet_erase_cmds yes \
    telnet_cmds yes


    # SMTP normalization and anomaly detection. For more information, see
        README.SMTP
    preprocessor smtp: ports { 25 465 587 691 } \
    inspection_type stateful \
    b64_decode_depth 0 \
    qp_decode_depth 0 \
    bitenc_decode_depth 0 \
    uu_decode_depth 0 \
    log_mailfrom \
    log_rcptto \
    log_filename \
    log_email_hdrs \
    normalize cmds \
    normalize_cmds { ATRN AUTH BDAT CHUNKING DATA DEBUG EHLO EMAL ESAM ESND
        ESOM ETRN EVFY } \
    normalize_cmds { EXPN HELO HELP IDENT MAIL NOOP ONEX QUEU QUIT RCPT RSET
        SAML SEND SOML } \
    normalize_cmds { STARTTLS TICK TIME TURN TURNME VERB VRFY X-ADAT X-DRCP
        X-ERCP X-EXCH50 } \
    normalize_cmds { X-EXPS X-LINK2STATE XADR XAUTH XCIR XEXCH50 XGEN XLICENSE
        XQUE XSTA XTRN XUSR } \
    max_command_line_len 512 \
    max_header_line_len 1000 \
    max_response_line_len 512 \
    alt_max_command_line_len 260 { MAIL } \
    alt_max_command_line_len 300 { RCPT } \
    alt_max_command_line_len 500 { HELP HELO ETRN EHLO } \
    alt_max_command_line_len 255 { EXPN VRFY ATRN SIZE BDAT DEBUG EMAL ESAM
        ESND ESOM EVFY IDENT NOOP RSET } \
    alt_max_command_line_len 246 { SEND SAML SOML AUTH TURN ETRN DATA RSET QUIT
        ONEX QUEU STARTTLS TICK TIME TURNME VERB X-EXPS X-LINK2STATE XADR XAUTH
        XCIR XEXCH50 XGEN XLICENSE XQUE XSTA XTRN XUSR } \
    valid_cmds { ATRN AUTH BDAT CHUNKING DATA DEBUG EHLO EMAL ESAM ESND ESOM
        ETRN EVFY } \
    valid_cmds { EXPN HELO HELP IDENT MAIL NOOP ONEX QUEU QUIT RCPT RSET SAML
        SEND SOML } \
    valid_cmds { STARTTLS TICK TIME TURN TURNME VERB VRFY X-ADAT X-DRCP X-ERCP
        X-EXCH50 } \
    valid_cmds { X-EXPS X-LINK2STATE XADR XAUTH XCIR XEXCH50 XGEN XLICENSE XQUE
        XSTA XTRN XUSR } \
    xlink2state { enabled }


    # Portscan detection. For more information, see README.sfportscan
    # preprocessor sfportscan: proto { all } memcap { 10000000 } sense_level {
        low }


    # ARP spoof detection. For more information, see the Snort Manual -
        Configuring Snort - Preprocessors - ARP Spoof Preprocessor
    # preprocessor arpspoof
    # preprocessor arpspoof_detect_host: 192.168.40.1 f0:0f:00:f0:0f:00


    # SSH anomaly detection. For more information, see README.ssh
    preprocessor ssh: server_ports { 22 } \
    autodetect \
    max_client_bytes 19600 \
    max_encrypted_packets 20 \
    max_server_version_len 100 \
    enable_respoverflow enable_ssh1crc32 \
    enable_srvoverflow enable_protomismatch


    # SMB / DCE-RPC normalization and anomaly detection. For more information,
        see README.dcerpc2
    preprocessor dcerpc2: memcap 102400, events [co ]
    preprocessor dcerpc2_server: default, policy WinXP, \
    detect [smb [139,445], tcp 135, udp 135, rpc-over-http-server 593], \
    autodetect [tcp 1025:, udp 1025:, rpc-over-http-server 1025:], \
    smb_max_chain 3, smb_invalid_shares ["C$", "D$", "ADMIN$"]


    # DNS anomaly detection. For more information, see README.dns
    preprocessor dns: ports { 53 } enable_rdata_overflow


    # SSL anomaly detection and traffic bypass. For more information, see
        README.ssl
    preprocessor ssl: ports { 443 465 563 636 989 992 993 994 995 7801 7802
        7900 7901 7902 7903 7904 7905 7906 7907 7908 7909 7910 7911 7912 7913
        7914 7915 7916 7917 7918 7919 7920 }, trustservers, noinspect_encrypted


    # SDF sensitive data preprocessor. For more information see
        README.sensitive_data
    preprocessor sensitive_data: alert_threshold 25


    # SIP Session Initiation Protocol preprocessor. For more information see
        README.sip
    preprocessor sip: max_sessions 40000, \
    ports { 5060 5061 5600 }, \
    methods { invite \
    cancel \
    ack \
    bye \
    register \
    options \
    refer \
    subscribe \
    update \
    join \
    info \
    message \
    notify \
    benotify \
    do \
    qauth \
    sprack \
    publish \
    service \
    unsubscribe \
    prack }, \
    max_uri_len 512, \
    max_call_id_len 80, \
    max_requestName_len 20, \
    max_from_len 256, \
    max_to_len 256, \
    max_via_len 1024, \
    max_contact_len 512, \
    max_content_len 2048


    # IMAP preprocessor. For more information see README.imap
    preprocessor imap: \
    ports { 143 } \
    b64_decode_depth 0 \
    qp_decode_depth 0 \
    bitenc_decode_depth 0 \
    uu_decode_depth 0


    # POP preprocessor. For more information see README.pop
    preprocessor pop: \
    ports { 110 } \
    b64_decode_depth 0 \
    qp_decode_depth 0 \
    bitenc_decode_depth 0 \
    uu_decode_depth 0


    # Modbus preprocessor. For more information see README.modbus
    preprocessor modbus: ports { 502 }


    # DNP3 preprocessor. For more information see README.dnp3
    preprocessor dnp3: ports { 20000 } \
    memcap 262144 \
    check_crc


    # Reputation preprocessor. For more information see README.reputation
    preprocessor reputation: \
    memcap 500, \
    priority whitelist, \
    nested_ip inner, \
    ##################################################
    Step #6: Configure output plugins
    For more information, see Snort Manual, Configuring Snort - Output Modules
    ##################################################
    unified2
    Recommended for most installs
    Additional configuration for specific types of installs
    output alert_unified2: filename snort.alert, limit 128, nostamp
    output log_unified2: filename snort.log, limit 128, nostamp
    syslog
    output alert_syslog: LOG_AUTH LOG_ALERT
    # output unified2: filename snort.log, limit 128, mpls_event_types,
        vlan_event_types
    pcap
    output log_tcpdump: pcap.log
    metadata reference data. do not modify these lines
    ##################################################
    Step #7: Customize your rule set
    For more information, see Snort Manual, Writing Snort Rules


    NOTE: All categories are enabled in this conf file
    ##################################################
    site specific rules
    # include $RULE_PATH/local.rules
    ##################################################
    Step #8: Customize your preprocessor and decoder alerts
    For more information, see README.decoder_preproc_rules
    ##################################################
    decoder and preprocessor event rules
    include $PREPROC_RULE_PATH/preprocessor.rules
    include $PREPROC_RULE_PATH/decoder.rules
    include $PREPROC_RULE_PATH/sensitive-data.rules
    ##################################################
    Step #9: Customize your Shared Object Snort Rules
    For more information, see
        http://vrt-blog.snort.org/2009/01/using-vrt-certified-shared-object-rules.html
    ##################################################
    dynamic library rules
    include $SO_RULE_PATH/bad-traffic.rules
    include $SO_RULE_PATH/chat.rules
    include $SO_RULE_PATH/dos.rules
    include $SO_RULE_PATH/exploit.rules
    include $SO_RULE_PATH/icmp.rules
    include $SO_RULE_PATH/imap.rules
    include $SO_RULE_PATH/misc.rules
    include $SO_RULE_PATH/multimedia.rules
    include $SO_RULE_PATH/netbios.rules
    include $SO_RULE_PATH/nntp.rules
    include $SO_RULE_PATH/p2p.rules
    include $SO_RULE_PATH/smtp.rules
    include $SO_RULE_PATH/snmp.rules
    include $SO_RULE_PATH/specific-threats.rules
    include $SO_RULE_PATH/web-activex.rules
    include $SO_RULE_PATH/web-client.rules
    include $SO_RULE_PATH/web-iis.rules
    include $SO_RULE_PATH/web-misc.rules
    include /root/snort-2.9.11.1/etc/rules/rule_used_in_lda.rules
    Event thresholding or suppression commands. See threshold.conf
--]]
-- alert_csv ={ file = true , fields = "timestamp"}
unified2 = { legacy_events = true , nostamp = false}
