﻿using NUnit.Framework;

namespace SpecsFor.Mvc.Demo.AcceptanceTests
{
	[SetUpFixture]
	public class DemoWebAppConfig : SpecsForMvcConfig
	{
		public DemoWebAppConfig()
		{
			UseIISExpressWith(Project("SpecsFor.Mvc.Demo"));
			BuildRoutesUsing(r => MvcApplication.RegisterRoutes(r));
			UseBrowser(BrowserDriver.InternetExplorer);

			//TODO: Open questions to be answered:
			//1) How do we point the app at a database for testing?
		}

		[SetUp]
		public override void SetupTestRun()
		{
			base.SetupTestRun();
		}

		[TearDown]
		public override void TearDownTestRun()
		{
			base.TearDownTestRun();
		}
	}
}