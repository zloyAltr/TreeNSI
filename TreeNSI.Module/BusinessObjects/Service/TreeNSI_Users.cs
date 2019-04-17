using System;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Validation;
using DevExpress.Persistent.Base.General;
using DevExpress.Persistent.Base;
using DevExpress.ExpressApp.Security;
using DevExpress.Persistent.Base.Security;
using System.Data.Entity.ModelConfiguration;
using DevExpress.ExpressApp;
using DevExpress.Data.Filtering;
using DevExpress.Persistent.BaseImpl.EF;
using DevExpress.Persistent.BaseImpl.EF.PermissionPolicy;



namespace TreeNSI.Module.BusinessObjects
{
    [Table("TreeNSI_Users")]
    //[DefaultClassOptions]
    public class TreeNSI_Users : IXafEntityObject, IObjectSpaceLink//: User//
        , ISecurityUser, IAuthenticationActiveDirectoryUser, ISecurityUserWithRoles, IPermissionPolicyUser, ICanInitialize
    {
        public TreeNSI_Users()
        {
            IsActive = true;
            TreeNSI_UsersRoles = new List<TreeNSI_UsersRoles>();
        }

        [Key]
        [Column("IdUser")]
        [Browsable(false)]
        public int IdUser { get; protected set; }
        [Required]
        [FieldSize(50)]
        public string FIO { get; set; }
        [FieldSize(38)]
        public string IdEmploy { get; set; }
        //[FieldSize(70)]
        //public string ADName { get; set; }
        

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            //IsActive = true;
            //ADName = SecuritySystem.CurrentUserName;
        }
        #endregion initialization

        void IXafEntityObject.OnLoaded()
        {
        }

        void IXafEntityObject.OnSaving()
        {
        }

        private IObjectSpace objectSpace;
        IObjectSpace IObjectSpaceLink.ObjectSpace
        {
            get { return objectSpace; }
            set { objectSpace = value; }
        }
        #endregion IXafEntityObject

        #region ISecurityUser Members
        [RuleRequiredField("EmployeeUserNameRequired", DefaultContexts.Save)]
        [RuleUniqueValue("EmployeeUserNameIsUnique", DefaultContexts.Save,
         "The login with the entered user name was already registered within the system.")]
        [Column("ADName")]
        public string UserName { get; set; }
        [Required]
        public bool IsActive { get; set; }
        #endregion

        #region ISecurityUserWithRoles Members
        IList<ISecurityRole> ISecurityUserWithRoles.Roles
        {
            get
            {
                IList<ISecurityRole> result = new List<ISecurityRole>();
                foreach (TreeNSI_UsersRoles role in TreeNSI_UsersRoles)
                {
                    result.Add(role);
                }
                return result;
            }
        }
        #endregion

        [RuleRequiredField("EmployeeRoleIsRequired", DefaultContexts.Save, TargetCriteria = "IsActive", CustomMessageTemplate = "An active employee must have at least one role assigned")]
        //[InverseProperty("TreeNSIUsers")]
        public virtual IList<TreeNSI_UsersRoles> TreeNSI_UsersRoles { get; set; }

        #region IPermissionPolicyUser Members
        IEnumerable<IPermissionPolicyRole> IPermissionPolicyUser.Roles
        {
            get { return TreeNSI_UsersRoles.OfType<IPermissionPolicyRole>(); }
        }
        #endregion

        #region ICanInitialize Members
        void ICanInitialize.Initialize(IObjectSpace objectSpace, SecurityStrategyComplex security)
        {
            TreeNSI_UsersRoles newUserRole = (TreeNSI_UsersRoles)objectSpace.FindObject<TreeNSI_UsersRoles>(new BinaryOperator("Name", security.NewUserRoleName));
            if (newUserRole == null)
            {
                newUserRole = objectSpace.CreateObject<TreeNSI_UsersRoles>();
                newUserRole.Name = security.NewUserRoleName;
                newUserRole.IsAdministrative = true;
                newUserRole.TreeNSI_Users.Add(this);
            }
        }
        #endregion
    }
}
