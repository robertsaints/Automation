# d-Con %QAAUTOMATION_SCRIPTS%\GameStopRespMobile\spec\UI\mgs_responsive_browse_spec.rb  --csv %QAAUTOMATION_SCRIPTS%\GameStopRespMobile\spec\UI\mgs_responsive_dataset.csv --range MGS_01 --browser chrome --or
# robert santos
require "#{ENV['QAAUTOMATION_SCRIPTS']}/GameStopRespMobile/dsl/src/dsl"
require "bigdecimal"
#--------------------------------------- 02b
$tracer.mode=:on
$tracer.echo=:on
$global_functions = GlobalFunctions.new()

#USER_AGENT_STR = "Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25"
USER_AGENT_STR = "Mozilla/5.0 (Linux; U; Android 2.2; en-us; SCH-I800 Build/FROYO) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1"

$tc_desc = $global_functions.desc
$tc_id = $global_functions.id
$tracer.trace("THIS IS TEST DESC #{$tc_desc} \nTHIS IS TEST ID #{$tc_id}")

describe "GS Responsive Mobile" do

  before(:all) do
    $options.http_proxy = "localhost"
    $options.http_proxy_port = "18252"
    @proxy = ProxyServerManager.new(18252)
    @proxy.start
    @proxy.set_request_header("User-Agent", USER_AGENT_STR)

    if browser_type_parameter == "chrome"
      @browser = WebBrowser.new(browser_type_parameter, true)
    else
      @browser = WebBrowser.new(browser_type_parameter)
    end
    
		# @browser.set_size(375, 667) #iPHONE 6 screen size
		@browser.set_size(1024, 600) #Samsung Galaxy Tab screen size

		
		@browser.delete_internet_files(browser_type_parameter)
    $options.default_timeout = 10_000
    $snapshots.setup(@browser, :all)

    #Get the parameters from the csv dataset
    @params = $global_functions.csv
    @sql = $global_functions.sql_file
    @db = $global_functions.db_conn
    @login = $global_functions.login
    @password = $global_functions.password
    @start_page = $global_functions.prop_url.find_value_by_name("url")
    @catalog_svc, @catalog_svc_version = $global_functions.catalog_svc
    @cart_svc, @cart_svc_version = $global_functions.cart_svc
    @account_svc, @account_svc_version = $global_functions.account_svc
    @profile_svc, @profile_svc_version = $global_functions.profile_svc
    @digital_wallet_svc, @digital_wallet_version = $global_functions.digitalwallet_svc
    @purchase_order_svc, @purchase_order_svc_version = $global_functions.purchaseorder_svc
    @velocity_svc, @velocity_svc_version = $global_functions.velocity_svc 
    @shipping_svc, @shipping_svc_version = $global_functions.shipping_svc
  end

  before(:each) do
    @before_env_name, @before_release_id = @browser.get_octopus_release
    $tracer.report("Environment : #{@before_env_name}, Release ID : #{@before_release_id}")
    $tracer.trace("#{@env_name}; #{@release_id}")
    @browser.delete_all_cookies_and_verify
    @session_id = generate_guid
  end

  after(:each) do
    @browser.return_current_url
  end

  after(:all) do
    @after_env_name, @after_release_id = @browser.get_octopus_release
    $tracer.report("Environment : #{@after_env_name}, Release ID : #{@after_release_id}")
    @browser.close_all()
  end

  it "#{$tc_id} #{$tc_desc}" do
    @browser.open("#{@start_page}/browse")
		sleep 5
    # @browser.wait_for_landing_page_load
    
		#-----------------------------------------------------------------------------
		@browser.div.id("/results/").should_exist
		@browser.div.className("/sorting/").should_exist
		@browser.div.className("/sorting/").ul.li.should_exist
		
		
		#-----------------------------------------------------------------------------
		@browser.mgs_filter_button.should_not be_visible
		puts "-----------------------------------   #{@browser.mgs_filter_button.should_not be_visible}"
		sleep 10
		$tracer.report("This is my first script in GS Responsive Mobile.")
		
  end

end