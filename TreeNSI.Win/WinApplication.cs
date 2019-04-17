﻿using System;
using System.ComponentModel;
using DevExpress.ExpressApp;
using DevExpress.ExpressApp.Win;
using System.Collections.Generic;
using DevExpress.ExpressApp.Updating;
using DevExpress.ExpressApp.Xpo;
using DevExpress.ExpressApp.Security;
using DevExpress.ExpressApp.Security.ClientServer;
using DevExpress.ExpressApp.EF;
using TreeNSI.Module.BusinessObjects;
using System.Data.Common;
using System.Configuration;

namespace TreeNSI.Win {
    // For more typical usage scenarios, be sure to check out https://documentation.devexpress.com/eXpressAppFramework/DevExpressExpressAppWinWinApplicationMembersTopicAll.aspx
    public partial class TreeNSIWindowsFormsApplication : WinApplication {
        #region Default XAF configuration options (https://www.devexpress.com/kb=T501418)
        static TreeNSIWindowsFormsApplication() {
            DevExpress.Persistent.Base.PasswordCryptographer.EnableRfc2898 = true;
            DevExpress.Persistent.Base.PasswordCryptographer.SupportLegacySha512 = false;
        }
        private void InitializeDefaults() {
            LinkNewObjectToParentImmediately = false;
            OptimizedControllersCreation = true;
            UseLightStyle = true;
        }
        #endregion
        public TreeNSIWindowsFormsApplication() {
            InitializeComponent();
			InitializeDefaults();
        }
        protected override void CreateDefaultObjectSpaceProvider(CreateCustomObjectSpaceProviderEventArgs args) {
            //args.ObjectSpaceProviders.Add(new SecuredObjectSpaceProvider((SecurityStrategyComplex)Security, XPObjectSpaceProvider.GetDataStoreProvider(ConfigurationManager.ConnectionStrings["ConnectionStringEF"].ConnectionString, null, true), false));//"ConnectionStringXpo"
            //         args.ObjectSpaceProviders.Add(new EFObjectSpaceProvider(typeof(TreeNSIDbContext), ConfigurationManager.ConnectionStrings["ConnectionStringEF"].ConnectionString));//"ConnectionStringEF"
            //         args.ObjectSpaceProviders.Add(new NonPersistentObjectSpaceProvider(TypesInfo, null));
            //11,02,2019
            if (args.Connection != null)
            {
                args.ObjectSpaceProviders.Add(new EFObjectSpaceProvider(typeof(TreeNSIDbContext), TypesInfo, null, (DbConnection)args.Connection));
            }
            else
            {
                args.ObjectSpaceProviders.Add(new EFObjectSpaceProvider(typeof(TreeNSIDbContext), TypesInfo, null, args.ConnectionString));
            }
            args.ObjectSpaceProviders.Add(new NonPersistentObjectSpaceProvider(TypesInfo, null));
        }
        private void TreeNSIWindowsFormsApplication_CustomizeLanguagesList(object sender, CustomizeLanguagesListEventArgs e) {
            string userLanguageName = System.Threading.Thread.CurrentThread.CurrentUICulture.Name;
            if(userLanguageName != "en-US" && e.Languages.IndexOf(userLanguageName) == -1) {
                e.Languages.Add(userLanguageName);
            }
        }
        private void TreeNSIWindowsFormsApplication_DatabaseVersionMismatch(object sender, DevExpress.ExpressApp.DatabaseVersionMismatchEventArgs e) {
#if DEBUG
            e.Updater.Update();
            e.Handled = true;
#else
            if(System.Diagnostics.Debugger.IsAttached) {
                e.Updater.Update();
                e.Handled = true;
            }
            else {
				string message = "The application cannot connect to the specified database, " +
					"because the database doesn't exist, its version is older " +
					"than that of the application or its schema does not match " +
					"the ORM data model structure. To avoid this error, use one " +
					"of the solutions from the https://www.devexpress.com/kb=T367835 KB Article.";

				if(e.CompatibilityError != null && e.CompatibilityError.Exception != null) {
					message += "\r\n\r\nInner exception: " + e.CompatibilityError.Exception.Message;
				}
				throw new InvalidOperationException(message);
            }
#endif
        }
    }
}
