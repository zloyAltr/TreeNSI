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
using System.Data.Entity.ModelConfiguration;
using DevExpress.ExpressApp;

namespace TreeNSI.Module.BusinessObjects
{
    public class DbMethods
    {
        const string CONNECTION_NAME = "name=ConnectionString";
        public static int? Registration(int idTypeDirectory)
        {
            int? _return = null;

            using (var command = new TreeNSIDbContext(CONNECTION_NAME).Database.Connection.CreateCommand())
            {
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.CommandText = "dbo.usp_TreeNSI_DirectoryRegistration";

                System.Data.SqlClient.SqlParameter idType = new System.Data.SqlClient.SqlParameter("@directoryType", idTypeDirectory);
                System.Data.SqlClient.SqlParameter idUser = new System.Data.SqlClient.SqlParameter("@user", SecuritySystem.CurrentUserId);
                System.Data.SqlClient.SqlParameter _id = new System.Data.SqlClient.SqlParameter("@returnId", System.Data.SqlDbType.Int);
                _id.IsNullable = true;
                _id.Direction = System.Data.ParameterDirection.Output;
                System.Data.SqlClient.SqlParameter _dateReg = new System.Data.SqlClient.SqlParameter("@returnRegistrationDate", System.Data.SqlDbType.DateTime);
                _dateReg.IsNullable = true;
                _dateReg.Direction = System.Data.ParameterDirection.Output;

                command.Parameters.Add(idType);
                command.Parameters.Add(idUser);
                command.Parameters.Add(_id);
                command.Parameters.Add(_dateReg);

                command.Connection.Open();
                var _result = command.ExecuteScalar();
                
                if (_id.Value != null)
                {
                    try
                    {
                        var _Value = Convert.ToInt32(_id.Value);
                        if (_Value > 0)
                            _return = _Value;
                    }
                    catch
                    {

                    }
                }
            }
            if (_return.HasValue)
                return _return;
            else
                throw new Exception("Элемент не зарегистрирован!");
        }

        public static bool UnRegistration(int idTypeDirectory, int idCatalog)
        {
            bool _return = false;
            using (var command = new TreeNSIDbContext(CONNECTION_NAME).Database.Connection.CreateCommand())
            {
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.CommandText = "dbo.usp_TreeNSI_DirectoryUnRegistration";

                System.Data.SqlClient.SqlParameter idType = new System.Data.SqlClient.SqlParameter("@directoryType", idTypeDirectory);
                System.Data.SqlClient.SqlParameter id = new System.Data.SqlClient.SqlParameter("@catalogId", idCatalog);
                System.Data.SqlClient.SqlParameter idUser = new System.Data.SqlClient.SqlParameter("@user", SecuritySystem.CurrentUserId);
                System.Data.SqlClient.SqlParameter _errorMassage = new System.Data.SqlClient.SqlParameter("@errorMassage", System.Data.SqlDbType.VarChar);
                _errorMassage.Size = 1000;
                _errorMassage.Direction = System.Data.ParameterDirection.Output;

                command.Parameters.Add(idType);
                command.Parameters.Add(id);
                command.Parameters.Add(idUser);
                command.Parameters.Add(_errorMassage);

                command.Connection.Open();
                var _result = command.ExecuteScalar();

                if (String.IsNullOrWhiteSpace(_errorMassage.Value.ToString()) /*&& _result.HasValue && _result.Value == 0*/)
                    _return = true;
                string _error = _errorMassage.Value.ToString();
                if (!String.IsNullOrWhiteSpace(_error))
                    throw new Exception(_error.Trim());
                //if (!_result.HasValue || _result.Value != 0)
                //    throw new Exception("Снятие с регитсрации не возможно!");

            }
            return _return;
        }
    }
}
