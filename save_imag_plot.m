function varargout = save_imag_plot(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @save_imag_plot_OpeningFcn, ...
                   'gui_OutputFcn',  @save_imag_plot_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before save_imag_plot is made visible.
function save_imag_plot_OpeningFcn(hObject, eventdata, handles, varargin)
movegui(hObject,'center')
img=imread('colores.tif');
axes(handles.axes1)
imshow(img)
axis off
handles.img=img;

% Choose default command line output for save_imag_plot
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = save_imag_plot_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- FUNCIÓN DEL BOTÓN "CONVERTIR"
function convertir_Callback(hObject, eventdata, handles)
% Convertir imagen
img=handles.img;
gris=rgb2gray(img);
axes(handles.axes2)
imshow(gris)
% Mostrar el histograma I
axes(handles.axes3)
imhist(gris);
% Mostrar el histograma II
axes(handles.axes4)
[counts,x] =imhist(gris);
stem(x,counts)

% --- FUNCIÓN DEL BOTÓN "GUARDAR"
function guardar_Callback(hObject, eventdata, handles)
% Guardar imagen
% Obtener imagen del axes
rgb = getimage(handles.axes2);
if isempty(rgb), return, end
% Guardar archivo
formatos = {'*.jpg','JPEG (*.jpg)';'*.tif','TIFF (*.tif)'};
[nomb,ruta] = uiputfile(formatos,'GUARDAR IMAGEN');
if nomb==0, return, end
fName = fullfile(ruta,nomb);
imwrite(rgb,fName);
% -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
formatos = {'*.bmp','BMP (*.bmp)'};
[nomb,ruta] = uiputfile(formatos,'GUARDAR HISTOGRAMA');
if nomb==0, return, end
% Crear nueva figura
figura = figure;
% Unidades y posición
unidades  = get(handles.axes4,'Units');
posicion   = get(handles.axes4,'Position');
objeto_2  = copyobj(handles.axes4,figura);
% Modificar la nueva figura
set(objeto_2,'Units',unidades);
set(objeto_2,'Position',[15 5 posicion(3) posicion(4)]);
% Ajustar la nueva figura
set(figura,'Units',unidades);
set(figura,'Position',[15 5 posicion(3)+30 posicion(4)+10]);
% Guardar la gráfica
saveas(figura,[ruta nomb]) 
%Cerrar figura
close(figura)