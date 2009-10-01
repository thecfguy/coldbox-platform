<cfcomponent extends="coldbox.system.testing.BaseTestCase" output="false">
<cfscript>
	function setup(){
		flash = getMockBox().createMock("coldbox.system.web.flash.SessionFlash");
		mockController = getMockBox().createMock(className="coldbox.system.Controller");
		flash.init(mockController);
		
		//test scope
		testscope = {test="luis",date=now()};
	}	
	function teardown(){ 
		structClear(session);
	}
	function testClearFlash(){
		session[flash.getFlashKey()] = testscope;
		flash.clearFlash();
		assertTrue( structIsEmpty(session[flash.getFlashKey()]));
	}
	function testSaveFlash(){
		flash.$("getScope",testscope);
		flash.saveFlash();
		assertEquals( session[flash.getFlashKey()], testscope );
	}
	function testFlashExists(){
		assertFalse( flash.flashExists() );
		session[flash.getFlashKey()] = testscope;
		assertTrue( flash.flashExists() );
	}
	function testgetFlash(){
		assertEquals( flash.getFlash(), structNew());
		
		session[flash.getFlashKey()] = testscope;
		assertEquals( flash.getFlash(), testScope);
	}
</cfscript>
</cfcomponent>