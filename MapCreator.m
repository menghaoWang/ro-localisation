function varargout = MapCreator(varargin)
% MAPCREATOR M-file for MapCreator.fig
%      MAPCREATOR, by itself, creates a new MAPCREATOR or raises the existing
%      singleton*.
%
%      H = MAPCREATOR returns the handle to a new MAPCREATOR or the handle to
%      the existing singleton*.
%
%      MAPCREATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAPCREATOR.M with the given input arguments.
%
%      MAPCREATOR('Property','Value',...) creates a new MAPCREATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MapCreator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MapCreator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MapCreator

% Last Modified by GUIDE v2.5 25-Nov-2016 10:04:28

% Begin initialization code - DO NOT EDIT

%varargin{1} = 回调函数名
%varargin{2} = hObject          当前回调函数对应的GUI句柄
%varargin{3} = eventdata        附加参数
%varargin{4} = handles          当前GUI所有数据的结构体，包含所有对象的句柄和用户定义的数据


global WAYPOINTS BEACONS
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MapCreator_OpeningFcn, ...
                   'gui_OutputFcn',  @MapCreator_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);

if nargin && ischar(varargin{1})%执行回调函数
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end



% End initialization code - DO NOT EDIT


% --- Executes just before MapCreator is made visible.
function MapCreator_OpeningFcn(hObject, eventdata, handles, varargin)%执行完，窗口可见，
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MapCreator (see VARARGIN)

% Choose default command line output for MapCreator
handles.output = hObject;
clc
% Update handles structure
guidata(hObject, handles);%更新handles

% UIWAIT makes MapCreator wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global WAYPOINTS BEACONS
BEACONS = [];
WAYPOINTS = [];

% --- Outputs from this function are returned to the command line.
function varargout = MapCreator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in beacon.
function beacon_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to beacon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global BEACONS
if (~get(handles.beacon, 'value'))
    return;
end
disp('set beacon');
set(handles.waypoint, 'value', 0)

 [xn,yn,bn]= ginput(1);
  while ~isempty(xn) && bn == 1
      BEACONS= [BEACONS [xn;yn]]
      axes(handles.axes1); hold on;
      plot(BEACONS(1,:),BEACONS(2,:),'g*');
      [xn,yn,bn]= ginput(1);
  end   

% Hint: get(hObject,'Value') returns toggle state of beacon

% --- Executes on button press in waypoint.
function waypoints_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to waypoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bbb = 1
if (~get(handles.waypoint, 'value'))
    return;
end
disp('set waypoint');
set(handles.beacon, 'value', 0)

global WAYPOINTS
[xn,yn,bn]= ginput(1);
  while ~isempty(xn) && bn == 1
        WAYPOINTS= [WAYPOINTS [xn;yn]]
        axes(handles.axes1); hold on;
        plot(WAYPOINTS(1,:),WAYPOINTS(2,:),'-r');
         plot(WAYPOINTS(1,:),WAYPOINTS(2,:),'r*');
        [xn,yn,bn]= ginput(1);     
  end   
 
% Hint: get(hObject,'Value') returns toggle state of waypoint

% --- Executes on button press in pushbutton1.
function save_button_Callback(hObject, eventdata, handles)

set(handles.beacon, 'value', 0);
set(handles.waypoint, 'value', 0);
global WAYPOINTS BEACONS
wp= WAYPOINTS; 
bec= BEACONS;
seed = {'*.mat','MAT-files (*.mat)'};
[fn,pn] = uiputfile(seed, 'Save BEACONS and WAYPOINTS');
if fn==0, return, end
fnpn = strrep(fullfile(pn,fn), '''', '''''');
save(fnpn, 'wp', 'bec');
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton2.
function clear_button_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.beacon, 'value', 0);
set(handles.waypoint, 'value', 0);
WAYPOINTS = [];
BEACONS = [];
axes(handles.axes1);
cla

