using DevExpress.Persistent.Base;
using DevExpress.Persistent.BaseImpl.EF.PermissionPolicy;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TreeNSI.Module.BusinessObjects
{
    [ImageName("BO_Role")]
    public class TreeNSI_UsersRoles : PermissionPolicyRoleBase, IPermissionPolicyRoleWithUsers
    {
        public TreeNSI_UsersRoles()
            :base()
        {

        }

        public virtual IList<TreeNSI_Users> TreeNSI_Users { get; set; }
        IEnumerable<IPermissionPolicyUser> IPermissionPolicyRoleWithUsers.Users
        {
            get { return TreeNSI_Users.OfType<IPermissionPolicyUser>(); }
        }
    }
}
