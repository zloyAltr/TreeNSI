using DevExpress.Persistent.Base;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.Persistent.BaseImpl.EF.PermissionPolicy;
using System;
using System.Collections.Generic;
using System.Linq;
using DevExpress.ExpressApp.Security;

namespace TreeNSI.Module.BusinessObjects
{
    [ImageName("BO_Role")]
    [Table("TreeNSI_Role")]
    public class Roles : PermissionPolicyRoleBase /*IPermissionPolicyRole, ISecurityRole, ISecuritySystemRole, INavigationPermissions*/, IPermissionPolicyRoleWithUsers
    {
        public Roles() : base() {
            //PermissionPolicy = SecurityPermissionPolicy.AllowAllByDefault;
        }

        [Key]
        [Column("IdRole")]
        [Browsable(false)]
        public int IdRole { get; protected set; }

        public virtual IList<TreeNSI_Users> TreeNSIUsers { get; set; }
        IEnumerable<IPermissionPolicyUser> IPermissionPolicyRoleWithUsers.Users
        {
            get { return TreeNSIUsers.OfType<IPermissionPolicyUser>();
            }
        }
        /*
        #region IPermissionPolicyRole
        public bool IsAdministrative { get; set; }

        
        public string Name { get; set; }

        public bool CanEditModel { get; set; }

        public SecurityPermissionPolicy PermissionPolicy { get; set; }

        IEnumerable<IPermissionPolicyTypePermissionObject> IPermissionPolicyRole.TypePermissions
        {
            get { return TreeNSIUsers.OfType<IPermissionPolicyTypePermissionObject>();
            }
        }

        IPermissionPolicyTypePermissionObject IPermissionPolicyRole.CreateTypePermissionObject(Type targetType)
        {
            return PermissionSettingHelper.SetTypePermission(this, targetType, "FullAccess", SecurityPermissionState.Allow);
        }

        #endregion

        #region INavigationPermissions
        IEnumerable<IPermissionPolicyNavigationPermissionObject> INavigationPermissions.NavigationPermissions
        {
            get
            {
                IList<IPermissionPolicyNavigationPermissionObject> _list = new List<IPermissionPolicyNavigationPermissionObject>();
                _list.Add(PermissionSettingHelper.EnsureNavigationPermission(this, "Application"));
                return _list;
            }

        }

        IPermissionPolicyNavigationPermissionObject INavigationPermissions.CreateNavigationPermissionObject(string itemPath)
        {
            return PermissionSettingHelper.EnsureNavigationPermission(this, itemPath);
        }


        #endregion
        */
    }
}
