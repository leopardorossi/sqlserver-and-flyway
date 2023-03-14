CREATE TYPE ${flyway:defaultSchema}.type_id            FROM VARCHAR(100);
GO

CREATE TYPE ${flyway:defaultSchema}.type_code          FROM VARCHAR(50);
GO

CREATE TYPE ${flyway:defaultSchema}.type_shortdescr    FROM VARCHAR(100);
GO

CREATE TYPE ${flyway:defaultSchema}.type_longdescr     FROM VARCHAR(MAX);
GO

CREATE TYPE ${flyway:defaultSchema}.type_timestamp     FROM DATETIME2;
GO

CREATE TYPE ${flyway:defaultSchema}.type_date          FROM DATE;
GO

CREATE TYPE ${flyway:defaultSchema}.type_geocoordinate FROM DECIMAL(9,6);
GO

CREATE TABLE ${flyway:defaultSchema}.EntityObject (
  Id             ${flyway:defaultSchema}.type_id   NOT NULL
 ,EntityId       ${flyway:defaultSchema}.type_id   NOT NULL
 ,EntityObjectId ${flyway:defaultSchema}.type_id   NOT NULL
 ,CONSTRAINT PK_${flyway:defaultSchema}_EntityObject PRIMARY KEY CLUSTERED (Id)
);
GO

CREATE TABLE ${flyway:defaultSchema}.Parish (
  Id            ${flyway:defaultSchema}.type_id   NOT NULL
 ,ParishName    ${flyway:defaultSchema}.type_code NOT NULL
 ,ParentsCode   ${flyway:defaultSchema}.type_code NOT NULL
 ,EducatorsCode ${flyway:defaultSchema}.type_code NOT NULL
 ,CONSTRAINT PK_${flyway:defaultSchema}_Parish PRIMARY KEY CLUSTERED (Id)
);
GO

CREATE TABLE ${flyway:defaultSchema}.UserProfile (
  Id         ${flyway:defaultSchema}.type_id   NOT NULL
 ,[Name]     ${flyway:defaultSchema}.type_code NOT NULL
 ,Surname    ${flyway:defaultSchema}.type_code NOT NULL
 ,Username   ${flyway:defaultSchema}.type_code NOT NULL
 ,UserProfileTypeId ${flyway:defaultSchema}.type_id   NOT NULL
 ,ParishId   ${flyway:defaultSchema}.type_id   NOT NULL
 ,CONSTRAINT PK_${flyway:defaultSchema}_UserProfile PRIMARY KEY CLUSTERED (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_UserProfile_Parish FOREIGN KEY (ParishId) REFERENCES ${flyway:defaultSchema}.Parish (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_UserProfile_EntityObject FOREIGN KEY (UserProfileTypeId) REFERENCES ${flyway:defaultSchema}.EntityObject (Id)
);
GO

CREATE TABLE ${flyway:defaultSchema}.Activity (
  Id           ${flyway:defaultSchema}.type_id         NOT NULL
 ,Title        ${flyway:defaultSchema}.type_code       NOT NULL
 ,GlobalGoal   ${flyway:defaultSchema}.type_shortdescr
 ,ActivityDate ${flyway:defaultSchema}.type_timestamp  NOT NULL
 ,ParishId     ${flyway:defaultSchema}.type_id         NOT NULL
 ,CONSTRAINT PK_${flyway:defaultSchema}_Activity PRIMARY KEY CLUSTERED (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_Activity_Parish FOREIGN KEY (ParishId) REFERENCES ${flyway:defaultSchema}.Parish (Id)
);
GO

CREATE TABLE ${flyway:defaultSchema}.ActivityVariant (
  Id                    ${flyway:defaultSchema}.type_id NOT NULL
 ,ActivityVariantTypeId ${flyway:defaultSchema}.type_id NOT NULL
 ,CONSTRAINT PK_${flyway:defaultSchema}_ActivityVariant PRIMARY KEY CLUSTERED (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_ActivityVariant_EntityObject FOREIGN KEY (ActivityVariantTypeId) REFERENCES ${flyway:defaultSchema}.EntityObject (Id)
);
GO

CREATE TABLE ${flyway:defaultSchema}.Tool (
  Id       ${flyway:defaultSchema}.type_id   NOT NULL
 ,[Name]   ${flyway:defaultSchema}.type_code NOT NULL
 ,ParishId ${flyway:defaultSchema}.type_id   NOT NULL
 ,CONSTRAINT PK_${flyway:defaultSchema}_Tool PRIMARY KEY CLUSTERED (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_Tool_Parish FOREIGN KEY (ParishId) REFERENCES ${flyway:defaultSchema}.Parish (Id)
);
GO

CREATE TABLE ${flyway:defaultSchema}.Step (
  Id                ${flyway:defaultSchema}.type_id         NOT NULL
 ,StepName          ${flyway:defaultSchema}.type_code       NOT NULL
 ,StepGoal          ${flyway:defaultSchema}.type_shortdescr
 ,Descr             ${flyway:defaultSchema}.type_longdescr
 ,Duration          ${flyway:defaultSchema}.type_code
 ,ActivityVariantId ${flyway:defaultSchema}.type_id         NOT NULL
 ,CONSTRAINT PK_${flyway:defaultSchema}_Step PRIMARY KEY CLUSTERED (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_Step_ActivityVariant FOREIGN KEY (ActivityVariantId) REFERENCES ${flyway:defaultSchema}.ActivityVariant (Id)
);
GO

CREATE TABLE ${flyway:defaultSchema}.StepUserProfile (
  Id     ${flyway:defaultSchema}.type_id NOT NULL
 ,StepId ${flyway:defaultSchema}.type_id NOT NULL
 ,UserProfileId ${flyway:defaultSchema}.type_id NOT NULL
 ,CONSTRAINT PK_${flyway:defaultSchema}_StepUserProfile PRIMARY KEY CLUSTERED (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_StepUserProfile_UserProfile FOREIGN KEY (UserProfileId) REFERENCES ${flyway:defaultSchema}.UserProfile (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_StepUserProfile_Step FOREIGN KEY (StepId) REFERENCES ${flyway:defaultSchema}.Step (Id)
 ,CONSTRAINT UK_${flyway:defaultSchema}_StepUserProfile UNIQUE (StepId, UserProfileId)
);
GO

CREATE TABLE ${flyway:defaultSchema}.StepTool (
  Id     ${flyway:defaultSchema}.type_id NOT NULL
 ,StepId ${flyway:defaultSchema}.type_id NOT NULL
 ,ToolId ${flyway:defaultSchema}.type_id NOT NULL
 ,CONSTRAINT PK_${flyway:defaultSchema}_StepTool PRIMARY KEY CLUSTERED (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_StepTool_Step FOREIGN KEY (StepId) REFERENCES ${flyway:defaultSchema}.Step (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_StepTool_Tool FOREIGN KEY (ToolId) REFERENCES ${flyway:defaultSchema}.Tool (Id)
 ,CONSTRAINT UK_${flyway:defaultSchema}_StepTool UNIQUE (StepId, ToolId)
);
GO

CREATE TABLE ${flyway:defaultSchema}.[Role] (
  Id    ${flyway:defaultSchema}.type_id         NOT NULL
 ,Code  ${flyway:defaultSchema}.type_code       NOT NULL
 ,Descr ${flyway:defaultSchema}.type_shortdescr
 ,CONSTRAINT PK_${flyway:defaultSchema}_Role PRIMARY KEY CLUSTERED (Id)
);
GO

CREATE TABLE ${flyway:defaultSchema}.UserProfileRole (
  Id     ${flyway:defaultSchema}.type_id NOT NULL
 ,UserProfileId ${flyway:defaultSchema}.type_id NOT NULL
 ,RoleId ${flyway:defaultSchema}.type_id NOT NULL
 ,CONSTRAINT PK_${flyway:defaultSchema}_UserProfileRole PRIMARY KEY CLUSTERED (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_UserProfileRole_UserProfile FOREIGN KEY (UserProfileId) REFERENCES ${flyway:defaultSchema}.UserProfile (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_UserProfileRole_Role FOREIGN KEY (RoleId) REFERENCES ${flyway:defaultSchema}.[Role] (Id)
 ,CONSTRAINT UK_${flyway:defaultSchema}_UserProfileRole UNIQUE (UserProfileId, RoleId)
);
GO

CREATE TABLE ${flyway:defaultSchema}.Permission (
  Id    ${flyway:defaultSchema}.type_id         NOT NULL
 ,Code  ${flyway:defaultSchema}.type_code       NOT NULL
 ,Descr ${flyway:defaultSchema}.type_shortdescr
 ,CONSTRAINT PK_${flyway:defaultSchema}_Permission PRIMARY KEY CLUSTERED (Id)
);
GO

CREATE TABLE ${flyway:defaultSchema}.RolePermission (
  Id           ${flyway:defaultSchema}.type_id NOT NULL
 ,RoleId       ${flyway:defaultSchema}.type_id NOT NULL
 ,PermissionId ${flyway:defaultSchema}.type_id NOT NULL
 ,CONSTRAINT PK_${flyway:defaultSchema}_RolePermission PRIMARY KEY CLUSTERED (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_RolePermission_Role FOREIGN KEY (RoleId) REFERENCES ${flyway:defaultSchema}.[Role] (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_RolePermission_Permission FOREIGN KEY (PermissionId) REFERENCES ${flyway:defaultSchema}.Permission (Id)
 ,CONSTRAINT UK_${flyway:defaultSchema}_RolePermission UNIQUE (RoleId, PermissionId)
);
GO

CREATE TABLE ${flyway:defaultSchema}.Kid (
  Id          ${flyway:defaultSchema}.type_id   NOT NULL
 ,[Name]      ${flyway:defaultSchema}.type_code NOT NULL
 ,[Surname]   ${flyway:defaultSchema}.type_code NOT NULL
 ,DateOfBirth ${flyway:defaultSchema}.type_date NOT NULL
 ,UserProfileId      ${flyway:defaultSchema}.type_id   NOT NULL
 ,CONSTRAINT PK_${flyway:defaultSchema}_Kid PRIMARY KEY CLUSTERED (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_Kid_UserProfile FOREIGN KEY (UserProfileId) REFERENCES ${flyway:defaultSchema}.UserProfile (Id)
);
GO

CREATE TABLE ${flyway:defaultSchema}.ActivityKid (
  Id         ${flyway:defaultSchema}.type_id NOT NULL
 ,ActivityId ${flyway:defaultSchema}.type_id NOT NULL
 ,KidId      ${flyway:defaultSchema}.type_id NOT NULL
 ,CONSTRAINT PK_${flyway:defaultSchema}_ActivityKid PRIMARY KEY CLUSTERED (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_ActivityKid_Actvity FOREIGN KEY (ActivityId) REFERENCES ${flyway:defaultSchema}.Activity (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_ActivityKid_Kid FOREIGN KEY (KidId) REFERENCES ${flyway:defaultSchema}.Kid (Id)
 ,CONSTRAINT UK_${flyway:defaultSchema}_ActivityKid UNIQUE (ActivityId, KidId)
);
GO

CREATE TABLE ${flyway:defaultSchema}.Survey (
  Id           ${flyway:defaultSchema}.type_id   NOT NULL
 ,Title        ${flyway:defaultSchema}.type_code NOT NULL
 ,SurveyTypeId ${flyway:defaultSchema}.type_id   NOT NULL
 ,CONSTRAINT PK_${flyway:defaultSchema}_Survey PRIMARY KEY CLUSTERED (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_Survey_EntityObject FOREIGN KEY (SurveyTypeId) REFERENCES ${flyway:defaultSchema}.EntityObject (Id)
);
GO

CREATE TABLE ${flyway:defaultSchema}.SurveyChoice (
  Id           ${flyway:defaultSchema}.type_id   NOT NULL
 ,Title        ${flyway:defaultSchema}.type_code NOT NULL
 ,SurveyId    ${flyway:defaultSchema}.type_id    NOT NULL
 ,CONSTRAINT PK_${flyway:defaultSchema}_SurveyChoice PRIMARY KEY CLUSTERED (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_SurveyChoice_Survey FOREIGN KEY (SurveyId) REFERENCES ${flyway:defaultSchema}.Survey (Id)
);
GO

CREATE TABLE ${flyway:defaultSchema}.UserProfileSurveyChoice (
  Id             ${flyway:defaultSchema}.type_id NOT NULL
 ,UserProfileId         ${flyway:defaultSchema}.type_id NOT NULL
 ,SurveyChoiceId ${flyway:defaultSchema}.type_id NOT NULL
 ,CONSTRAINT PK_${flyway:defaultSchema}_UserProfileSurveyChoice PRIMARY KEY CLUSTERED (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_UserProfileSurveyChoice_UserProfile FOREIGN KEY (UserProfileId) REFERENCES ${flyway:defaultSchema}.UserProfile (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_UserProfileSurveyChoice_SurveyChoice FOREIGN KEY (SurveyChoiceId) REFERENCES ${flyway:defaultSchema}.SurveyChoice (Id)
 ,CONSTRAINT UK_${flyway:defaultSchema}_UserProfileSurveyChoice UNIQUE (UserProfileId, SurveyChoiceId)
);
GO

CREATE TABLE ${flyway:defaultSchema}.Calendar (
  Id       ${flyway:defaultSchema}.type_id         NOT NULL
 ,[Name]   ${flyway:defaultSchema}.type_code       NOT NULL
 ,Descr    ${flyway:defaultSchema}.type_shortdescr 
 ,StartTs  ${flyway:defaultSchema}.type_timestamp  NOT NULL
 ,EndTs    ${flyway:defaultSchema}.type_timestamp  NOT NULL
 ,ParishId ${flyway:defaultSchema}.type_id         NOT NULL
 ,CONSTRAINT PK_${flyway:defaultSchema}_Calendar PRIMARY KEY CLUSTERED (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_Calendar_Parish FOREIGN KEY (ParishId) REFERENCES ${flyway:defaultSchema}.Parish (Id)
);
GO

CREATE TABLE ${flyway:defaultSchema}.CalendarEvent (
  Id            ${flyway:defaultSchema}.type_id         NOT NULL
 ,Title         ${flyway:defaultSchema}.type_code       NOT NULL
 ,Descr         ${flyway:defaultSchema}.type_shortdescr 
 ,EventTs       ${flyway:defaultSchema}.type_timestamp  NOT NULL
 ,EventTypeId   ${flyway:defaultSchema}.type_id         NOT NULL
 ,EventLocation ${flyway:defaultSchema}.type_shortdescr 
 ,Latitude      ${flyway:defaultSchema}.type_geocoordinate
 ,Longitude     ${flyway:defaultSchema}.type_geocoordinate
 ,ActivityId    ${flyway:defaultSchema}.type_id
 ,SurveyId      ${flyway:defaultSchema}.type_id
 ,CONSTRAINT PK_${flyway:defaultSchema}_CalendarEvent PRIMARY KEY CLUSTERED (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_CalendarEvent_Activity FOREIGN KEY (ActivityId) REFERENCES ${flyway:defaultSchema}.Activity (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_CalendarEvent_Survey FOREIGN KEY (SurveyId) REFERENCES ${flyway:defaultSchema}.Survey (Id)
 ,CONSTRAINT FK_${flyway:defaultSchema}_CalendarEvent_EntityObject FOREIGN KEY (EventTypeId) REFERENCES ${flyway:defaultSchema}.EntityObject (Id)
);
GO
